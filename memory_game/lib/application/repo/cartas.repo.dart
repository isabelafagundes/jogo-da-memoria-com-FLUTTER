import 'package:memory_game/application/domain/carta.dart';

abstract class CartasRepo {

  Future<List<Carta>> obterCartas();

}