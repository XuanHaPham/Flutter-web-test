import 'dart:html';

import 'package:flutter/semantics.dart';
import 'package:http/http.dart' as http;
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
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _urlController = TextEditingController();
  String _resultMessage = ''; // Variable to store result message

  Future<void> _submitUrl() async {
    String url = _urlController.text;
    setState(() {
      _resultMessage = 'Submitting...'; // Show loading message
    });

    try {
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _resultMessage = 'Success: ${response.statusCode}'; // Success message
        });
      } else {
        setState(() {
          _resultMessage = 'Failed: ${response.statusCode}'; // Failure message
        });
      }
    } catch (e) {
      setState(() {
        _resultMessage = 'Error: $e'; // Error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const labelStr =
        '2 text Header text Header text Header text Header text Header text Header text Header text Header text Header text Header text';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: labelStr,
            // attributedLabel: AttributedString(
            //   labelStr,
            //   attributes: [
            //     LocaleStringAttribute(
            //         range: TextRange(start: 0, end: labelStr.length),
            //         locale: Locale('en', 'US'))
            //   ],
            // ),
            button: true,
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
            label: 'Text input field',
            child: TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your URL',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Semantics(
            label: 'Submit button',
            child: ElevatedButton(
              onPressed: _submitUrl,
              child: const Text('Submit'),
            ),
          ),
          const SizedBox(height: 20),
          Semantics(
            label: 'Result message',
            child: Text(
              _resultMessage, // Display the result message here
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
