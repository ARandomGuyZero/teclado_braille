import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TecladoManager {
  Widget buildTeclado(Function(String) onPressed) {
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

    return Wrap(
      children: List.generate(27, (index) {
        final letra =
            index == 26 ? 'ñ' : String.fromCharCode('A'.codeUnitAt(0) + index);
        final braille = brailleMap[letra.toLowerCase()] ?? letra;
        return Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () => onPressed(letra.toLowerCase()),
            child: Text(braille),
          ),
        );
      }),
    );
  }

  void manejarEventoTeclado(RawKeyEvent event, Function(String) onPressed) {
    if (event is RawKeyDownEvent) {
      final String letra = event.logicalKey.keyLabel.toLowerCase();
      if (letra.isNotEmpty && RegExp(r'[a-zñ]').hasMatch(letra)) {
        onPressed(letra);
      }
    }
  }
}
