import 'dart:io';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatelessWidget {
  final File imageFile;

  const CameraPreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}