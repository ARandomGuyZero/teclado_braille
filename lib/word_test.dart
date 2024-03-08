import 'package:flutter/material.dart';
import 'dart:math';

class WordTest extends StatefulWidget {
  const WordTest({super.key});

  @override
  WordTestState createState() => WordTestState();
}

class WordTestState extends State<WordTest> {
  late String word;
  TextEditingController controller = TextEditingController();
  late bool correct;

  @override
  void initState() {
    super.initState();
    _generateRandomWord();
    correct = false;
  }

  void _generateRandomWord() {
    final List<String> words = ['apple', 'banana', 'orange', 'grape', 'kiwi'];
    final Random random = Random();
    word = words[random.nextInt(words.length)];
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
              // Mostrar la palabra aquí
              word, // Utiliza la palabra generada
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
          ],
        ),
      ),
    );
  }

  void _checkWord() {
    final enteredWord = controller.text.toLowerCase();
    setState(() {
      correct = enteredWord == word;
    });
  }
}
