import 'package:flutter/material.dart';
import 'package:memory_game/application/domain/dificuldade.dart';
import 'package:memory_game/interface/contants.dart';
import 'package:memory_game/interface/widgets/texto.widget.dart';

class MenuWidget extends StatefulWidget {
  final Function(Dificuldade) aoClicar;

  const MenuWidget({super.key, required this.aoClicar});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  String _label = Dificuldade.FACIL.descricao;
  int _indiceHover = -1;
  Dificuldade? _dificuldade;
  bool _visivel = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry != null && _overlayEntry!.mounted) return _removerOverlay();
          setState(() => _visivel = !_visivel);
          RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
          Offset containerPosition = renderBox.localToGlobal(Offset.zero);
          _exibirOverlay(context, containerPosition);
        },
        child: Container(
          key: _key,
          width: 285,
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
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextoWidget(
                texto: _label,
                tamanhoFonte: 14,
                fontFamily: 'Baloo',
                cor: laranja,
                sombras: [],
              ),
              Icon(
                _visivel ? Icons.expand_less : Icons.expand_more,
                color: laranja,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _exibirOverlay(BuildContext context, Offset containerPosition) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: containerPosition.dy + 58,
          left: containerPosition.dx,
          child: GestureDetector(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 285,
                height: 108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: vermelho,
                  boxShadow: [
                    BoxShadow(
                      color: laranja,
                      offset: Offset(0, 2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Dificuldade.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MouseRegion(
                        onEnter: (e) => setState(() => _indiceHover = index),
                        onExit: (e) => setState(() => _indiceHover = -1),
                        child: GestureDetector(
                          onTap: () {
                            _removerOverlay();
                            setState(() {
                              _label = Dificuldade.values[index].descricao;
                              _indiceHover = -1;
                              _dificuldade = Dificuldade.values[index];
                              widget.aoClicar(_dificuldade!);
                            });
                          },
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: _indiceHover == index ? laranjaClaro : vermelho,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: TextoWidget(
                                fontFamily: 'Baloo',
                                texto: Dificuldade.values[index].descricao,
                                tamanhoFonte: 14,
                                cor: laranja,
                                sombras: [],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removerOverlay() {
    if (_overlayEntry != null && _overlayEntry!.mounted) _overlayEntry!.remove();
    setState(() => _visivel = false);
  }
}
