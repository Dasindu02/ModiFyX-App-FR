import 'dart:io';
import 'package:flutter/material.dart';
// import 'car_preview.dart';
import 'package:image_picker/image_picker.dart';

class UploadCarImages extends StatefulWidget {
  const UploadCarImages({super.key});

  @override
  State<UploadCarImages> createState() => _UploadCarImagesState();
}

class _UploadCarImagesState extends State<UploadCarImages> {
  File? frontImage;
  File? backImage;
  File? leftImage;
  File? rightImage;

  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  Future pickImage(Function(File) setImage) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        setImage(File(picked.path));
      });
    }
  }

  Widget imageBox(String title, File? image, Function(File) setImage) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => pickImage(setImage),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: image == null
                ? const Icon(Icons.add_a_photo, size: 40)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(image, fit: BoxFit.cover),
                  ),
          ),
        )
      ],
    );
  }

  void showMaintenancePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.build_circle,
                    size: 60, color: Colors.orange),
                const SizedBox(height: 10),
                const Text(
                  "Feature Under Maintenance",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "This feature is currently unavailable.\nPlease try again later.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("OK"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void generate3DCar() {
    showMaintenancePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Car Images"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageBox("Front", frontImage, (f) => frontImage = f),
                  imageBox("Back", backImage, (f) => backImage = f),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageBox("Left", leftImage, (f) => leftImage = f),
                  imageBox("Right", rightImage, (f) => rightImage = f),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: generate3DCar,
                child: const Text("Generate 3D Car"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}