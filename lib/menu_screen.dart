import 'package:flutter/material.dart';
import 'character_test.dart';
import 'word_test.dart';
import 'ble_screen.dart'; // Importar la pantalla ble_screen.dart

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
        child: ListView(
          children: [
            _buildMenuItem(
              context,
              'Ir al juego de caracteres',
              'Completa las letras',
              const CharacterTest(),
            ),
            _buildMenuItem(
              context,
              'Ir al juego de palabras',
              'Adivina la palabra',
              const WordTest(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla ble_screen.dart cuando se presiona el botón
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const BleScreen()), // Reemplaza BleScreen con el nombre correcto de tu pantalla
          );
        },
        tooltip:
            'Agregar', // Texto que se muestra cuando se mantiene presionado el botón
        child: const Icon(Icons.add), // Icono del botón flotante
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
