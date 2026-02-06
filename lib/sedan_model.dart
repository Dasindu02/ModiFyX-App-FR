import 'package:flutter/material.dart';

class SedanModel extends StatelessWidget {
  const SedanModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sedan Page'),
      ),
      body: const Center(
        child: Text(
          'Hello – This is the Sedan page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}