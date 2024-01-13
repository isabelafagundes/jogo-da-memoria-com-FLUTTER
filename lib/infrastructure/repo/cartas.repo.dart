import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/repo/cartas.repo.dart';

class CartasImplRepo implements CartasRepo {
  @override
  Future<List<Carta>> obterCartas() async {
    return [
      Carta.carregar(1, 'assets/pngs/abobora.png'),
      Carta.carregar(2, 'assets/pngs/boneco.png'),
      Carta.carregar(3, 'assets/pngs/bruxa.png'),
      Carta.carregar(4, 'assets/pngs/espantalho.png'),
      Carta.carregar(5, 'assets/pngs/livro.png'),
      Carta.carregar(6, 'assets/pngs/olho.png'),
      Carta.carregar(7, 'assets/pngs/vampiro.png'),
      Carta.carregar(8, 'assets/pngs/zumbi.png'),
      Carta.carregar(9, 'assets/pngs/chapeu.png'),
    ];
  }
}
