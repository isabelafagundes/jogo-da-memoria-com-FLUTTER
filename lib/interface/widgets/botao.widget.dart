import 'package:flutter/material.dart';
import 'package:memory_game/interface/constants.dart';
import 'package:memory_game/interface/widgets/texto.widget.dart';

class BotaoWidget extends StatelessWidget {
  final Function() aoClicar;
  final String label;

  const BotaoWidget({super.key, required this.aoClicar, required this.label});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: aoClicar,
        child: Container(
          width: 300,
          height: 40,
          decoration: BoxDecoration(
            color: vermelho,
            border: Border.all(color: amarelo),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: laranja,
                offset: Offset(0, 0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Center(
            child: TextoWidget(
              texto: label,
              tamanhoFonte: 18,
              fontFamily: 'Baloo',
              cor: Colors.white,
              sombras: [],
            ),
          ),
        ),
      ),
    );
  }
}
