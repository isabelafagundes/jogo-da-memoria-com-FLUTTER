import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/domain/dificuldade.dart';
import 'package:memory_game/application/domain/jogo.dart';
import 'package:memory_game/application/domain/selecao.dart';
import 'package:memory_game/application/repo/cartas.repo.dart';
import 'package:memory_game/application/state/jogo.state.dart';

class JogoUseCase {
  final CartasRepo _repo;
  final JogoState _state;

  JogoUseCase(this._repo, this._state);

  Future<void> iniciarJogo([Dificuldade dificuldade = Dificuldade.FACIL]) async {
    List<Carta> cartas = await _repo.obterCartas();
    _reiniciarState();
    _criarJogo(cartas, dificuldade);
    _embaralharCartas(cartas);
  }

  void _reiniciarState() {
    _state.selecao = Selecao.criar();
    _state.finalizarJogo = false;
    _state.tentativas = 40;
  }

  void _criarJogo(List<Carta> cartas, [Dificuldade dificuldade = Dificuldade.FACIL]) {
    Map<int, Carta> cartasPorId = {};
    for (Carta carta in cartas) cartasPorId[carta.id] = carta;
    Jogo jogo = Jogo.carregar(cartasPorId, dificuldade);
    _state.jogo = jogo;
  }

  void _embaralharCartas(List<Carta> cartas) {
    _state.cartas = cartas.expand((e) => [e, e]).toList();
    _state.cartas.shuffle();
  }

  Future<void> efetuarSelecao(Carta? carta, int index) async {
    _state.selecao.atualizarSelecao(carta, index);
    await verificarSelecao();
  }

  Future<void> verificarSelecao() async {
    if (_state.selecao.verificarParEncontrado()) {
      int id = _state.selecao.primeiraSelecao!;
      _state.cartas[id].definirComoEncontrada();
    }
    await definirComoNaoSelecionada();
  }

  Future<void> definirComoNaoSelecionada() async {
    if (_state.selecao.verificarIndicesPreenchidos) {
      _decrementarTentativas();
      await Future.delayed(
        const Duration(seconds: 1),
        () => _state.selecao = Selecao.criar(),
      );
    }
  }

  void _decrementarTentativas() {
    if (_state.jogo!.dificuldade == Dificuldade.DIFICIL) _state.tentativas--;
    if (_state.tentativas == 0) _state.finalizarJogo = true;
  }
}
