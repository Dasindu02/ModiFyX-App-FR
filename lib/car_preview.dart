import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CarPreview extends StatelessWidget {
  const CarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D Car Preview"),
      ),
      body: const ModelViewer(
        src: 'assets/models/cartoon_car.glb', 
        alt: "3D Car",
        autoRotate: true,
        cameraControls: true,
        ar: true,
      ),
    );
  }
}
