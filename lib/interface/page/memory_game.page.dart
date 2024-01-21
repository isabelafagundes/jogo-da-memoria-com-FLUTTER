import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_game/application/component/jogo.component.dart';
import 'package:memory_game/application/domain/carta.dart';
import 'package:memory_game/application/domain/dificuldade.dart';
import 'package:memory_game/infrastructure/repo/cartas.repo.dart';
import 'package:memory_game/interface/constants.dart';
import 'package:memory_game/interface/widgets/carta.widget.dart';
import 'package:memory_game/interface/widgets/grid_cartas.widget.dart';
import 'package:memory_game/interface/widgets/menu.widget.dart';
import 'package:memory_game/interface/widgets/pop_up.widget.dart';
import 'package:memory_game/interface/widgets/texto.widget.dart';

class MemoryGamePage extends StatefulWidget {
  const MemoryGamePage({super.key});

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  final JogoComponent _component = JogoComponent();

  @override
  void initState() {
    super.initState();
    _component.inicializar(CartasImplRepo(), atualizar);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async => await _component.iniciarJogo());
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [amarelo.withOpacity(.6), Colors.transparent],
            begin: Alignment.topRight,
            end: Alignment.center,
          ),
          image: DecorationImage(
            fit: MediaQuery.of(context).size.width <= 500 ? BoxFit.fitHeight : BoxFit.fill,
            image: const AssetImage("assets/pngs/background.png"),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [amarelo.withOpacity(.4), Colors.transparent],
                begin: Alignment.bottomLeft,
                end: Alignment.center,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: _component.jogo == null
                    ? [
                        const CircularProgressIndicator(),
                      ]
                    : [
                        SizedBox(height: espacamento * 3),
                        TextoWidget(
                          texto: 'Jogo da Memoria',
                          tamanhoFonte: 62,
                          cor: amarelo,
                          sombras: [sombraLaranja],
                        ),
                        SizedBox(height: espacamento * 4),
                        MenuWidget(
                          aoClicar: (dificuldade) async => await _component.iniciarJogo(dificuldade),
                        ),
                        if (_component.jogo!.dificuldade == Dificuldade.DIFICIL)
                          Column(
                            children: [
                              SizedBox(height: espacamento * 2),
                              TextoWidget(
                                texto: "${_component.tentativas} chances",
                                tamanhoFonte: 40,
                                cor: amarelo,
                                sombras: [sombraLaranja],
                              ).animate().fade(),
                            ],
                          ),
                        _component.jogo!.dificuldade == Dificuldade.DIFICIL
                            ? const SizedBox()
                            : SizedBox(height: espacamento * 5),
                        Transform.scale(
                          scale: .9,
                          child: _obterGridCartas,
                        ),
                        SizedBox(height: espacamento * 4),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _obterGridCartas {
    return GridCartasWidget(
      quantidadeCartas: _component.cartas.length,
      builder: (BuildContext context, int index) {
        return IgnorePointer(
          ignoring: _component.manterExibicao(index),
          child: Container(
            child: CartaWidget(
              aoSelecionar: () => _selecionarCarta(index),
              selecionada: _component.manterExibicao(index),
              carta: _component.cartas[index],
            ).animate(target: _component.manterExibicao(index) ? 1 : 0).flip(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  direction: Axis.horizontal,
                  begin: 0,
                  end: -1,
                ),
          ).animate().fade(
                curve: Curves.easeOut,
                delay: Duration(milliseconds: 50 * index),
              ),
        );
      },
    );
  }

  void _exibirPopUp(bool usuarioPerdeu) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpWidget(
          aoIniciarJogo: () => Navigator.pop(context),
          usuarioPerdeu: usuarioPerdeu,
        );
      },
    );
  }

  Future<void> _selecionarCarta(int index) async {
    if (_component.selecao.segundaCarta != null) return;
    await _component.selecionarCartas(_component.cartas[index], index);
    await _manterExibicaoCarta();
  }

  Future<void> _manterExibicaoCarta() async {
    if (_component.paresNaoEncontrados == 0 || _component.finalizarJogo) {
      _exibirPopUp(_component.finalizarJogo);
      await _component.iniciarJogo();
    }
  }
}
