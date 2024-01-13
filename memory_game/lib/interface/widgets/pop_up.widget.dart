import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_game/interface/contants.dart';
import 'package:memory_game/interface/widgets/botao.widget.dart';
import 'package:memory_game/interface/widgets/texto.widget.dart';

class PopUpWidget extends StatelessWidget {
  final Function() aoIniciarJogo;
  final bool usuarioPerdeu;

  const PopUpWidget({
    super.key,
    required this.aoIniciarJogo,
    required this.usuarioPerdeu,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      backgroundColor: corCard,
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 500,
            height: 300,
            padding: EdgeInsets.symmetric(
              vertical: espacamento * 2,
              horizontal: espacamento * 3,
            ),
            child: Column(
              children: [
                TextoWidget(
                  texto: "Buuh!!",
                  tamanhoFonte: 48,
                  cor: amarelo,
                  sombras: [
                    Shadow(
                      color: laranja,
                      offset: Offset(0, 0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                SizedBox(height: espacamento * 3),
                TextoWidget(
                  texto: usuarioPerdeu
                      ? "Não foi desta vez! Você não terminou esse jogo da memória. Experimente  jogar novamente!"
                      : "Parabéns, você terminou esse jogo da memória. Experimente jogar uma outra dificuldade ou jogue na mesma novamente.",
                  tamanhoFonte: 18,
                  fontFamily: 'Baloo',
                  maxLines: 3,
                  cor: Colors.white,
                  sombras: [],
                ),
                SizedBox(height: espacamento * 5),
                BotaoWidget(
                  aoClicar: aoIniciarJogo,
                  label: 'Jogar novamente',
                ),
              ],
            ),
          ),
          Positioned(
            top: -20,
            right: -20,
            child: SvgPicture.asset('assets/svgs/teia.svg'),
          ),
        ],
      ),
    );
  }
}
