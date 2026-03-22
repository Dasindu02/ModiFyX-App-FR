import 'package:flutter/material.dart';
import 'ar_view_screen.dart';

class SedanModel extends StatefulWidget {
  const SedanModel({super.key});

  @override
  State<SedanModel> createState() => _SedanModelState();
}

class _SedanModelState extends State<SedanModel> {
  final TextEditingController carModelController = TextEditingController();
  String? selectedPart;
  bool showModifications = false;

  // Map each image to its corresponding 3D model
  final Map<String, String> imageToModel = {
    // Alloy Wheels
    "allowheel01": "assets/models/alloywheel+10.glb",
    "allowheel02": "assets/models/alloywheel+10.glb",
    "alloywheel03": "assets/models/alloywheel+10.glb",
    "allowheel04": "assets/models/alloywheel+14.glb",
    "allowheel05": "assets/models/alloywheel+14.glb",


    // Headlights
    "headlight": "assets/models/headlight.glb",

    // Spoilers
    "spoiler3": "assets/models/Spoiler+01.glb",
    "spoiler 7": "assets/models/spolier+4.glb",
    "spoiler2": "assets/models/spolier++02.glb",
  };

  bool get isFormValid {
    return carModelController.text.trim().isNotEmpty &&
        selectedPart != null;
  }

  @override
  void dispose() {
    carModelController.dispose();
    super.dispose();
  }

  // POPUP
  void showModificationPopup(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(imagePath, height: 120),
                    const SizedBox(height: 10),
                    const Text(
                      "Modification Option",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Details"),
                        ),
                        // TRY OUT BUTTON
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            String modelPath = imageToModel.entries
                                .firstWhere(
                                  (entry) => imagePath.contains(entry.key),
                                  orElse: () => const MapEntry("", ""),
                                )
                                .value;

                            if (modelPath.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ARViewScreen(modelPath: modelPath),
                                ),
                              );
                            } else {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("3D model not found")),
                              );
                            }
                          },
                          child: const Text("Try Out"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //  Return images based on the selected part
  List<String> getImages() {
    switch (selectedPart) {
      case "alloywheels":
        return [
          "assets/modificationpart/allowheel01.png",
          "assets/modificationpart/allowheel02.jpeg",
          "assets/modificationpart/alloywheel03.jpeg",
          "assets/modificationpart/allowheel04.png",
          "assets/modificationpart/allowheel05.jpeg",
        ];
      case "headlights":
        return [
          "assets/modificationpart/allowheel01.png", 
        ];
      case "spoiler":
        return [
          "assets/modificationpart/spoiler3.jpg",
          "assets/modificationpart/spoiler 7.jpg",
          "assets/modificationpart/spoiler2.jpg",
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = getImages();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ModiFyX",
                    style: TextStyle(
                      fontFamily: 'PostNoBillsColombo',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),

            const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Sedan Models",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Type a car model"),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: carModelController,
                decoration: const InputDecoration(
                  hintText: "Eg: Toyota Corolla",
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) {
                  setState(() {
                    showModifications = false;
                  });
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Select the Parts"),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<String>(
                value: selectedPart,
                hint: const Text("Select modification part"),
                items: const [
                  DropdownMenuItem(
                      value: "headlights", child: Text("Headlights")),
                  DropdownMenuItem(
                      value: "alloywheels", child: Text("Alloy Wheels")),
                  DropdownMenuItem(value: "spoiler", child: Text("Spoiler")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedPart = value;
                    showModifications = false;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                ),
                onPressed: isFormValid
                    ? () {
                        setState(() {
                          showModifications = true;
                        });
                      }
                    : null,
                child: const Text("Search"),
              ),
            ),

            const SizedBox(height: 10),

            if (showModifications)
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: images.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModificationPopup(images[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}