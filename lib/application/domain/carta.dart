class Carta {
  final int _id;
  final String _imagem;
  bool _parEncontrado;

  Carta.carregar(
    this._id,
    this._imagem, [
    this._parEncontrado = false,
  ]);

  String get imagem => _imagem;

  int get id => _id;

  bool get parEncontrado => _parEncontrado;


  void definirComoEncontrada() => _parEncontrado = true;

}
