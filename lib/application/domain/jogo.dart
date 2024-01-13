import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/domain/dificuldade.dart';

class Jogo {

  final Map<int, Carta> _cartasPorIndice;
  final Dificuldade _dificuldade;

  Jogo.carregar(this._cartasPorIndice, [this._dificuldade = Dificuldade.FACIL]);

  Dificuldade get dificuldade => _dificuldade;

  Map<int, Carta> get cartas => _cartasPorIndice;

}