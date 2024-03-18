// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import '../resources/teclado_manager.dart';

class JuegoBraille extends StatefulWidget {
  const JuegoBraille({super.key});

  @override
  _JuegoBrailleState createState() => _JuegoBrailleState();
}

class _JuegoBrailleState extends State<JuegoBraille> {
  final FocusNode _focusNode = FocusNode();
  String letraBraille = '';
  String? letraIngresada;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _seleccionarLetraAleatoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego de Braille'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) {
          TecladoManager().manejarEventoTeclado(event, _verificarRespuesta);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selecciona la letra correspondiente:',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                letraBraille,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20),
              TecladoManager().buildTeclado(_verificarRespuesta),
              const SizedBox(height: 20),
              if (letraIngresada != null)
                Text(
                  'Letra ingresada: $letraIngresada',
                  style: const TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _seleccionarLetraAleatoria() {
    const String alfabeto = 'abcdefghijklmnopqrstuvwxyz';
    final Random random = Random();
    final int indiceAleatorio = random.nextInt(alfabeto.length);
    final String letraAleatoria = alfabeto[indiceAleatorio];

    setState(() {
      letraBraille = letraAleatoria;
    });
  }

  void _verificarRespuesta(String letra) {
    setState(() {
      letraIngresada = letra;
    });

    // Muestra el resultado
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Resultado'),
        content: letra == letraBraille
            ? Text('¡Correcto! La letra es: $letra')
            : const Text('Incorrecto. Intenta de nuevo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (letra == letraBraille) {
                _seleccionarLetraAleatoria(); // Selecciona una nueva letra
                setState(() {
                  letraIngresada = null; // Reinicia la letra ingresada
                });
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
