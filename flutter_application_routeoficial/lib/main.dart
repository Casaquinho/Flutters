import 'package:flutter/material.dart';
import 'package:flutter_application_1/tela_principal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'doguinhos',
      routes: {
        'doguinhos': (context) => Doguinhos(),
        'gatos': (context) => Gatos(),
        'passaros': (context) => Passaros(),
      },
      home: TelaPricipal(),
    );
  }
}
