import 'package:flutter/material.dart';

class HatchbackModel extends StatelessWidget {
  const HatchbackModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatchback Page'),
      ),
      body: const Center(
        child: Text(
          'Hello – This is the Hatchback page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}