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

  bool get isFormValid {
    return carModelController.text.trim().isNotEmpty &&
        selectedPart != null;
  }

  @override
  void dispose() {
    carModelController.dispose();
    super.dispose();
  }

  // 🔥 POPUP
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

                        // 🚀 TRY OUT BUTTON
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            // 🔥 MAP IMAGE → MODEL
                            String modelPath = "";

                            if (imagePath.contains("allowheel")) {
                              modelPath =
                                  "assets/models/alloywheel+10.glb";
                            } else if (imagePath.contains("headlight")) {
                              modelPath =
                                  "assets/models/headlight.glb";
                            } else if (imagePath.contains("spoiler")) {
                              modelPath =
                                  "assets/models/spoiler.glb";
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ARViewScreen(modelPath: modelPath),
                              ),
                            );
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

  List<String> getImages() {
    if (selectedPart == "alloywheels") {
      return [
        "assets/modificationpart/allowheel01.png",
        "assets/modificationpart/allowheel02.jpeg",
        "assets/modificationpart/alloywheel03.jpeg",
        "assets/modificationpart/allowheel04.png",
        "assets/modificationpart/allowheel05.jpeg",
      ];
    } else if (selectedPart == "headlights") {
      return [
        "assets/modificationpart/allowheel01.png",
      ];
    } else if (selectedPart == "spoiler") {
      return [
        "assets/modificationpart/allowheel02.jpeg",
      ];
    }
    return [];
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
                  DropdownMenuItem(value: "headlights", child: Text("Headlights")),
                  DropdownMenuItem(value: "alloywheels", child: Text("Alloy Wheels")),
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