import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ARViewScreen extends StatefulWidget {
  final String modelPath;

  const ARViewScreen({super.key, required this.modelPath});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeCamera;
  final GlobalKey _stackKey = GlobalKey();

  // Drag & pinch state
  Offset modelOffset = Offset.zero;
  double modelScale = 1.0;
  double previousScale = 1.0;

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
      ResolutionPreset.high,
    );

    _initializeCamera = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  // Capture AR view and save as PNG to external storage
 Future<void> capturePhoto() async {
  try {
    RenderRepaintBoundary boundary =
        _stackKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save to app documents directory (safe)
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "AR_Capture_${DateTime.now().millisecondsSinceEpoch}.png";
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);

    await file.writeAsBytes(pngBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Photo saved locally: $filePath")),
    );
  } catch (e) {
    print("Error capturing photo: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to capture photo.")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("AR View"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: capturePhoto,
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _stackKey,
        child: Stack(
          children: [
            // Camera preview
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

            // 3D model overlay with drag & pinch
            Positioned.fill(
              child: GestureDetector(
                onScaleStart: (details) {
                  previousScale = modelScale;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    modelScale = previousScale * details.scale;
                    modelOffset += details.focalPointDelta;
                  });
                },
                child: Transform.translate(
                  offset: modelOffset,
                  child: Transform.scale(
                    scale: modelScale,
                    child: ModelViewer(
                      src: widget.modelPath,
                      alt: "3D Model",
                      cameraControls: true,
                      backgroundColor: Colors.transparent,
                      autoRotate: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}