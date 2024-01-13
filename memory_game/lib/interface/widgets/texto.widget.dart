import 'package:flutter/material.dart';
import 'package:memory_game/interface/contants.dart';

class TextoWidget extends StatelessWidget {
  final String texto;
  final double tamanhoFonte;
  final Color cor;
  final bool negrito;
  final List<Shadow> sombras;
  final int maxLines;
  final String fontFamily;
  final TextAlign textAlign;

  const TextoWidget({
    super.key,
    required this.texto,
    required this.tamanhoFonte,
    required this.cor,
    this.negrito = false,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    required this.sombras,
    this.fontFamily = 'OctoberCrow',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        shadows: sombras,
        fontSize: tamanhoFonte,
        color: cor,
        fontWeight: negrito ? FontWeight.w600 : FontWeight.w400,
        fontFamily: fontFamily,
      ),
    );
  }
}
