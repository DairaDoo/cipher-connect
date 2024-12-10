import 'package:flutter/material.dart';
import 'screens/password_manager_screen.dart';


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
      home: const PasswordManagerScreen(), // Se referencia la clase actualizada
    );
  }
}
