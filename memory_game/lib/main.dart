import 'package:flutter/material.dart';
import 'package:memory_game/interface/page/memory_game.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da memória',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MemoryGamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

