import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  if (kIsWeb) {
    // Required on web/desktop to automatically enable accessibility features.
    WidgetsFlutterBinding.ensureInitialized().ensureSemantics();

    document.addEventListener('keydown', (dynamic event) {
      if (event.code == 'Tab') {
        event.preventDefault();
      }
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'Home page title',
            child: const Text('Accessible Web UI'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Header text',
                child: const Text(
                  'Welcome to the Web UI',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Description text',
                child: const Text(
                  'This UI demonstrates how to use the Semantics widget for accessibility.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Submit button',
                child: ElevatedButton(
                  onPressed: () {
                    // Do something when pressed
                  },
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Text input field',
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Dropdown menu for selecting an option',
                child: DropdownButton<String>(
                  value: 'Option 1',
                  onChanged: (String? newValue) {},
                  items: <String>['Option 1', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
