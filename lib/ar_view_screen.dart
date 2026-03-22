import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:camera/camera.dart';

class ARViewScreen extends StatefulWidget {
  final String modelPath;

  const ARViewScreen({super.key, required this.modelPath});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeCamera;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _initializeCamera = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fixedPath =
        "file:///android_asset/flutter_assets/${widget.modelPath}";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("ModiFyX (AR View)"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          //REAL CAMERA controll 
          if (_cameraController != null)
            FutureBuilder(
              future: _initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

          // 3D MODEL OVERLAY
          Center(
            child: SizedBox(
              height: 180,
              child: ModelViewer(
                src: widget.modelPath,
                alt: "3D Model",
                // autoRotate: true,
                cameraControls: true,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}