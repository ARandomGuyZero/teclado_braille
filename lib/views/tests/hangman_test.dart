// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import '../resources/words.dart';
import '../resources/teclado_manager.dart';

class JuegoAhorcado extends StatefulWidget {
  const JuegoAhorcado({super.key});

  @override
  _EstadoJuegoAhorcado createState() => _EstadoJuegoAhorcado();
}

class _EstadoJuegoAhorcado extends State<JuegoAhorcado> {
  late String palabra;
  late List<bool> letrasAdivinadas;
  late int intentosRestantes;
  final FocusNode _nodoEnfoque = FocusNode();

  @override
  void initState() {
    super.initState();
    _nodoEnfoque.requestFocus();
    iniciarNuevoJuego();
  }

  void iniciarNuevoJuego() {
    final int indiceAleatorio = Random().nextInt(palabras.length);
    palabra = palabras[indiceAleatorio];
    letrasAdivinadas = List.generate(palabra.length, (_) => false);
    intentosRestantes = 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahorcado'),
      ),
      body: RawKeyboardListener(
        focusNode: _nodoEnfoque,
        onKey: (RawKeyEvent event) {
          TecladoManager().manejarEventoTeclado(event, adivinarLetra);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                palabraConLetrasAdivinadas(),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                'Intentos restantes: $intentosRestantes',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TecladoManager().buildTeclado(adivinarLetra),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void adivinarLetra(String letra) {
    if (intentosRestantes > 0 && !palabra.contains(letra)) {
      setState(() {
        intentosRestantes--;
      });
    }

    for (int i = 0; i < palabra.length; i++) {
      if (palabra[i] == letra) {
        setState(() {
          letrasAdivinadas[i] = true;
        });
      }
    }

    if (!letrasAdivinadas.contains(false)) {
      // Todas las letras han sido adivinadas
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('¡Felicidades!'),
          content: const Text('¡Has ganado!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                iniciarNuevoJuego();
              },
              child: const Text('Jugar de nuevo'),
            ),
          ],
        ),
      );
    } else if (intentosRestantes == 0) {
      // No hay más intentos
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Fin del juego'),
          content: Text('¡Has perdido! La palabra era: $palabra'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                iniciarNuevoJuego();
              },
              child: const Text('Intentar de nuevo'),
            ),
          ],
        ),
      );
    }
  }

  String palabraConLetrasAdivinadas() {
    String resultado = '';
    for (int i = 0; i < palabra.length; i++) {
      resultado += letrasAdivinadas[i] ? palabra[i] : '_';
      resultado += ' ';
    }
    return resultado;
  }
}
