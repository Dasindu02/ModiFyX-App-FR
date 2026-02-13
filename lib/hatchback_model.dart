import 'package:flutter/material.dart';

class HatchbackModel extends StatelessWidget {
  const HatchbackModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatchback Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Available Hatchback Models',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              Text('• Suzuki Swift'),
              Text('• Toyota Yaris'),
              Text('• Kia Picanto'),
              Text('• Hyundai i10'),
            ],
          ),
        ),
      ),
    );
  }
}