import 'package:flutter/material.dart';
import '../menu_screen.dart';

class BleScreen extends StatelessWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth LE'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BleDeviceScanScreen()),
            );
          },
          child: const Text('Escanear Dispositivos Bluetooth LE'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón de más
          // En este caso, navegaremos a la pantalla del menú
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuScreen()),
          );
        },
        tooltip: 'Menú',
        child: const Icon(Icons.menu),
      ),
    );
  }
}

class BleDeviceScanScreen extends StatelessWidget {
  const BleDeviceScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí implementarías la lógica para escanear dispositivos Bluetooth LE
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneo de Dispositivos Bluetooth LE'),
        centerTitle: true,
      ),
      body: const Center(
        child:
            CircularProgressIndicator(), // Ejemplo de indicador de progreso mientras se escanean dispositivos
      ),
    );
  }
}
