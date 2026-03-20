import 'dart:io';
import 'package:flutter/material.dart';
import 'car_preview.dart';
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

  void generate3DCar() async {
    if (frontImage != null &&
        backImage != null &&
        leftImage != null &&
        rightImage != null) {
      setState(() {
        isLoading = true; // show loading spinner
      });

      // simulate 3D generation delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      // navigate to preview
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CarPreview(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload all 4 car images"),
        ),
      );
    }
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
              /// FRONT / BACK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageBox("Front", frontImage, (f) => frontImage = f),
                  imageBox("Back", backImage, (f) => backImage = f),
                ],
              ),
              const SizedBox(height: 20),

              /// LEFT / RIGHT
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

          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
