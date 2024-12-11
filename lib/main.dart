import 'package:cipher_connect/screens/game_screen.dart';
import 'package:cipher_connect/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Elimina la marca de debug
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Estilo principal de la app
      ),
      home: const CeaserCipherGame(), // Se referencia la clase actualizada
    );
  }
}
