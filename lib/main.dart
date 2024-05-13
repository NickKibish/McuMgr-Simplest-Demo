import 'package:flutter/material.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final firmwareUpdateManagerFactory = FirmwareUpdateManagerFactory();
  FirmwareUpdateManager? _firmwareUpdateManager;

  void _createUpdateManager() async {
    // Bluetooth Permissions should be requested in this method
    final uuid = Uuid();
    final uuidString = uuid.v4();
    _firmwareUpdateManager =
        await firmwareUpdateManagerFactory.getUpdateManager(uuidString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async => _createUpdateManager(),
                child: const Text('Create Update Manager'),
              ),
            ],
          ),
        ));
  }
}
