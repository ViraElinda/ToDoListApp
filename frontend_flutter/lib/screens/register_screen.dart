import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';

final Logger logger = Logger('RegisterScreen');

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  Future<void> registerUser() async {
  final response = await http.post(
    Uri.parse('http://192.168.0.107:8000/api/register'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'name': _name.text,
      'email': _email.text,
      'password': _password.text,
      'password_confirmation': _passwordConfirm.text,
    },
  );

logger.info('Status: ${response.statusCode}');
logger.info('Response: ${response.body}');


  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    logger.info(decoded['message']);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    final error = utf8.decode(response.bodyBytes);
    logger.warning('Registration failed: $error');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi gagal')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextFormField(
              controller: _passwordConfirm,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
