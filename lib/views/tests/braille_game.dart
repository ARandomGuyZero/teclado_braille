// ignore_for_file: library_private_types_in_public_api

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
      body: Center(
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
    );
  }

  void _seleccionarLetraAleatoria() {
    // Mapa de letras braille
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

    // Selecciona una letra aleatoria
    final List<String> letras = brailleMap.keys.toList();
    final String letraAleatoria =
        letras[(DateTime.now().microsecondsSinceEpoch % letras.length)];
    setState(() {
      letraBraille = brailleMap[letraAleatoria]!;
    });
  }

  void _verificarRespuesta(String letra) {
    setState(() {
      letraIngresada = letra;
    });

    // Mapa de letras braille
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

    // Obtiene la letra correspondiente a la forma braille
    String? letraCorrespondiente;
    brailleMap.forEach((key, value) {
      if (value == letra) {
        letraCorrespondiente = key;
      }
    });

    // Muestra el resultado
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Resultado'),
        content: letraCorrespondiente != null
            ? Text('¡Correcto! La letra es: $letraCorrespondiente')
            : const Text('Incorrecto. Intenta de nuevo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (letraCorrespondiente != null) {
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
