// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../resources/teclado_manager.dart';

class JuegoCaracter extends StatefulWidget {
  const JuegoCaracter({super.key});

  @override
  _JuegoCaracterState createState() => _JuegoCaracterState();
}

class _JuegoCaracterState extends State<JuegoCaracter> {
  String? letraIngresada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego del Carácter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona una letra:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TecladoManager().buildTeclado(_adivinarLetra),
            const SizedBox(height: 20),
            if (letraIngresada != null)
              Text(
                'Letra ingresada: $letraIngresada\nBraille: ${_obtenerBraille(letraIngresada!)}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  void _adivinarLetra(String letra) {
    setState(() {
      letraIngresada = letra;
    });
  }

  String _obtenerBraille(String letra) {
    Map<String, String> brailleMap = {
      'a': '⠁',
      'b': '⠃',
      'c': '⠉',
      'd': '⠙',
      'e': '⠑',
      'f': '⠋',
      'g': '⠛',
      'h': '⠓',
      'i': '⠊',
      'j': '⠚',
      'k': '⠅',
      'l': '⠇',
      'm': '⠍',
      'n': '⠝',
      'ñ': '⠻',
      'o': '⠕',
      'p': '⠏',
      'q': '⠟',
      'r': '⠗',
      's': '⠎',
      't': '⠞',
      'u': '⠥',
      'v': '⠧',
      'w': '⠺',
      'x': '⠭',
      'y': '⠽',
      'z': '⠵',
    };
    return brailleMap[letra] ?? '';
  }
}
