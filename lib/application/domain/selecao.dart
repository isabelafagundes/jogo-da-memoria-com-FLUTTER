import 'package:memory_game/application/domain/carta.dart';

class Selecao {
  Carta? _primeiraCarta;
  Carta? _segundaCarta;
  int? _primeiraSelecao;
  int? _segundaSelecao;

  Selecao.criar();

  void atualizarSelecao(Carta? carta, int index) {
    if (_primeiraCarta == null) {
      this._primeiraCarta = carta;
      this._primeiraSelecao = index;
      return;
    } else if (_segundaCarta != _primeiraCarta) {
      this._segundaCarta = carta;
      this._segundaSelecao = index;
    }
  }

  bool get verificarIndicesPreenchidos => _primeiraSelecao != null && _segundaSelecao!=null;

  bool verificarParEncontrado() {
    if (_primeiraCarta != null && _segundaCarta != null) {
      return _primeiraCarta!.id == _segundaCarta!.id;
    }
    return false;
  }

  Carta? get segundaCarta => _segundaCarta;

  Carta? get primeiraCarta => _primeiraCarta;

  int? get segundaSelecao => _segundaSelecao;

  int? get primeiraSelecao => _primeiraSelecao;
}
