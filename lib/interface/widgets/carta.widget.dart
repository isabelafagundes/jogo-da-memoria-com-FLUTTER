import 'package:flutter/material.dart';
import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/interface/contants.dart';
import 'package:memory_game/interface/widgets/texto.widget.dart';

class CartaWidget extends StatelessWidget {
  final Function() aoSelecionar;
  final Carta carta;
  final bool selecionada;

  const CartaWidget({
    super.key,
    required this.aoSelecionar,
    required this.carta,
    required this.selecionada,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoSelecionar,
      child: Container(
        decoration: BoxDecoration(
          color: selecionada ? corCard : vermelho,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!selecionada)
              BoxShadow(
                color: laranja,
                offset: Offset(0, 0),
                blurRadius: 5.0,
              ),
          ],
        ),
        child: selecionada
            ? Image.asset(
                carta.imagem,
                height: 71,
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(color: amarelo, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextoWidget(
                    texto: '?',
                    tamanhoFonte: 70,
                    cor: amarelo,
                    sombras: [
                      Shadow(
                        color: laranja,
                        offset: Offset(0, 0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
