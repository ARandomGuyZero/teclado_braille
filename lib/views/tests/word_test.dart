import 'package:flutter/material.dart';
import 'dart:math';
import '../resources/teclado_manager.dart';
import '../resources/words.dart';

class WordTest extends StatefulWidget {
  const WordTest({super.key});

  @override
  WordTestState createState() => WordTestState();
}

class WordTestState extends State<WordTest> {
  late String palabra;
  TextEditingController controller = TextEditingController();
  late bool correct;

  @override
  void initState() {
    super.initState();
    _generateRandomWord();
    correct = false;
  }

  void _generateRandomWord() {
    final int indiceAleatorio = Random().nextInt(palabras.length);
    palabra = palabras[indiceAleatorio];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego de Palabras'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Escribe la palabra:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              palabra,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Ingresa la palabra aquí',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkWord,
              child: const Text('Revisar'),
            ),
            const SizedBox(height: 20),
            Text(
              correct ? '¡Correcto!' : 'Incorrecto',
              style: TextStyle(
                fontSize: 20,
                color: correct ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TecladoManager().buildTeclado(_onKeyPressed),
          ],
        ),
      ),
    );
  }

  void _checkWord() {
    final enteredWord = controller.text.toLowerCase();
    setState(() {
      correct = enteredWord == palabra;
    });

    if (correct) {
      // Mostrar el diálogo de ganar
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('¡Felicidades!'),
          content: const Text('¡Has ganado!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _generateRandomWord(); // Generar una nueva palabra
                controller.clear(); // Limpiar el campo de texto
                setState(() {
                  correct = false; // Reiniciar la bandera de correcto
                });
              },
              child: const Text('Jugar de nuevo'),
            ),
          ],
        ),
      );
    } else {
      // Mostrar el diálogo de perder
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Fin del juego'),
          content: Text('¡Has perdido! La palabra era: $palabra'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _generateRandomWord(); // Generar una nueva palabra
                controller.clear(); // Limpiar el campo de texto
                setState(() {
                  correct = false; // Reiniciar la bandera de correcto
                });
              },
              child: const Text('Intentar de nuevo'),
            ),
          ],
        ),
      );
    }
  }

  void _onKeyPressed(String key) {
    controller.text += key;
  }
}
