import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/domain/jogo.dart';
import 'package:memory_game/application/domain/selecao.dart';

mixin JogoState {
  Jogo? jogo;
  Selecao selecao = Selecao.criar();
  List<Carta> cartas = [];
  int tentativas = 10;
  bool finalizarJogo = false;

  bool vericarSeEstaSelecionada(int indexSelecionado) {
    return selecao.primeiraSelecao == indexSelecionado || selecao.segundaSelecao == indexSelecionado;
  }

  bool verificarSeEncontrou(int index) => cartas[index].parEncontrado;

  bool manterExibicao(int index) => verificarSeEncontrou(index)|| vericarSeEstaSelecionada(index);

  int get paresNaoEncontrados {
    int paresNaoEncontrados = 0;
    for (Carta carta in jogo!.cartas.values.toList()) {
      if (!carta.parEncontrado) paresNaoEncontrados++;
    }
    return paresNaoEncontrados;
  }
}
