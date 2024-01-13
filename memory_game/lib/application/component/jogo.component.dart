import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/domain/dificuldade.dart';
import 'package:memory_game/application/repo/cartas.repo.dart';
import 'package:memory_game/application/state/jogo.state.dart';
import 'package:memory_game/application/state/state.dart';
import 'package:memory_game/application/use_case/jogo.usecase.dart';

class JogoComponent with State, JogoState {
  late JogoUseCase _useCase;

  void inicializar(CartasRepo repo, Function() atualizar) {
    _useCase = JogoUseCase(repo, this);
    super.atualizar = atualizar;
  }

  Future<void> iniciarJogo([Dificuldade dificuldade = Dificuldade.FACIL]) async {
    return await executar(
      rotina: () async => _useCase.iniciarJogo(dificuldade),
      mensagemErro: "Ocorreu um erro ao iniciar o jogo, tente novamente!",
    );
  }

  Future<void> selecionarCartas(Carta? carta, int index) async {
    return await executar(
      rotina: () async => _useCase.efetuarSelecao(carta, index),
      mensagemErro: "Ocorreu um erro ao selecionar a carta, tente novamente!",
    );
  }
}
