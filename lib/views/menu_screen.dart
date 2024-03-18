import 'package:flutter/material.dart';
import 'package:teclado_braille/views/tests/braille_game.dart';
import 'package:teclado_braille/views/tests/character_test.dart';
import 'package:teclado_braille/views/tests/hangman_test.dart';
import 'package:teclado_braille/views/settings/ble_screen.dart';
import 'package:teclado_braille/views/tests/word_test.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JuegoCaracter()),
                );
              },
              child: const Text('Ir al juego de caracteres'),
            ),
            const SizedBox(
                height: 20), // Espacio entre el botón y la lista de juegos

            // Lista de juegos
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    context,
                    'Ir al juego de palabras',
                    'Escribe la palabra',
                    const JuegoBraille(),
                  ),
                  _buildMenuItem(
                    context,
                    'Ir al juego de palabras',
                    'Escribe la palabra',
                    const WordTest(),
                  ),
                  _buildMenuItem(
                    context,
                    'Ir al juego del ahorcado',
                    'Adivina la palabra',
                    const JuegoAhorcado(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BleScreen()),
          );
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
