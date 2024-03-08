// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleScreen extends StatelessWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BleScanner(),
    );
  }
}

class BleScanner extends StatefulWidget {
  const BleScanner({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BleScannerState createState() => _BleScannerState();
}

class _BleScannerState extends State<BleScanner> {
  late final FlutterReactiveBle _ble;
  Stream<List<DiscoveredDevice>>? _scanResults;

  @override
  void initState() {
    super.initState();
    _ble = FlutterReactiveBle(); // Inicializar FlutterReactiveBle
    _initializeBle(); // Inicializar el Bluetooth LE
    _startScan(); // Comenzar el escaneo
  }

  Future<void> _initializeBle() async {
    try {
      await _ble.initialize();
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing BLE: $e');
      }
    }
  }

  Future<void> _startScan() async {
    try {
      _scanResults = _ble.scanForDevices(
        withServices: [],
      ) as Stream<List<DiscoveredDevice>>?;
    } catch (e) {
      print('Error starting scan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Scanner'),
      ),
      body: StreamBuilder<List<DiscoveredDevice>>(
        stream: _scanResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final devices = snapshot.data!;
            return ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index].id),
                  subtitle: Text(devices[index].name),
                  onTap: () {},
                );
              },
            );
          } else {
            return const Center(
              child: Text('No se encontraron dispositivos.'),
            );
          }
        },
      ),
    );
  }
}
