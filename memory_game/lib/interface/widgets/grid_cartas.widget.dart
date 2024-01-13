import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/interface/contants.dart';

class GridCartasWidget extends StatelessWidget {
  final int quantidadeCartas;
  final IndexedWidgetBuilder builder;

  const GridCartasWidget({
    super.key,
    required this.quantidadeCartas,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: quantidadeCartas,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _obterQuantidadePorLinha(context),
          crossAxisSpacing: espacamento * 4,
          mainAxisSpacing: espacamento * 4,
          mainAxisExtent: 150,
        ),
        itemBuilder: builder,
      ),
    );
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1000) return 6;
    if (MediaQuery.of(context).size.width > 800) return 4;
    if (MediaQuery.of(context).size.width > 500) return 3;
    if (MediaQuery.of(context).size.width > 250) return 2;
    return 1;
  }
}
