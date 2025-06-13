import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webauthn_flutter/webauthn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebAuthn Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebAuthnExample(),
    );
  }
}

class WebAuthnExample extends StatefulWidget {
  const WebAuthnExample({super.key});

  @override
  State<WebAuthnExample> createState() => _WebAuthnExampleState();
}

class _WebAuthnExampleState extends State<WebAuthnExample> {
  String _message = '';
  bool _success = false;

  Future<void> _authenticate() async {
    final result = await WebauthnFlutter.authenticate();

    setState(() {
      _message = result['message'] ?? 'No message';
      _success = result['success'] == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton.icon(
                onPressed: _authenticate,
                icon: const Icon(Icons.fingerprint),
                label: const Text("Authenticate"),
              ),
              const SizedBox(height: 30),
              if (_message.isNotEmpty)
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 18,
                    color: _success ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
