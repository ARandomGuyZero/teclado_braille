import 'package:flutter/material.dart';
import 'dart:math';

class CharacterTest extends StatefulWidget {
  const CharacterTest({super.key});

  @override
  CharacterTestState createState() => CharacterTestState();
}

class CharacterTestState extends State<CharacterTest> {
  List<String> characters = [];
  List<TextEditingController> controllers = [];
  int correctCount = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomCharacters();
  }

  void _generateRandomCharacters() {
    final random = Random();
    characters = List.generate(5, (_) {
      final charCode = random.nextInt(26) + 65;
      return String.fromCharCode(charCode);
    });
    controllers = characters.map((_) => TextEditingController()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test de caracteres'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildCharacterText(index),
                        ),
                        Expanded(
                          flex: 3,
                          child: _buildInputField(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildResultText(),
            const SizedBox(height: 20),
            _buildButton(
                'Generar nuevos caracteres', _generateRandomCharacters),
            const SizedBox(height: 20),
            _buildButton('Comprobar respuestas', _checkAnswers),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterText(int index) {
    return Text(
      characters[index],
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }

  Widget _buildInputField(int index) {
    return Container(
      height: 60, // Reducir la altura del contenedor
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24, // Reducir el tamaño del texto
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildResultText() {
    return Text(
      'Respuestas correctas: $correctCount de ${characters.length}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _checkAnswers() {
    final count = controllers
        .where((controller) =>
            controller.text.toUpperCase() ==
            characters[controllers.indexOf(controller)])
        .length;
    setState(() {
      correctCount = count;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resultados'),
          content: Text('Respuestas correctas: $count de ${characters.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(fontSize: 28)),
            ),
          ],
        );
      },
    );
  }
}
