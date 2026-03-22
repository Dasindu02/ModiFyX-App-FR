import 'package:flutter/material.dart';
import 'ar_view_screen.dart';

class HatchbackModel extends StatefulWidget {
  const HatchbackModel({super.key});

  @override
  State<HatchbackModel> createState() => _HatchbackModelState();
}

class _HatchbackModelState extends State<HatchbackModel> {
  final TextEditingController carModelController = TextEditingController();
  String? selectedPart;
  bool showModifications = false;

  final Map<String, String> imageToModel = {
    "allowheel01": "assets/models/alloywheel+13.glb",
    "allowheel02": "assets/models/alloywheel+10.glb",
    "alloywheel03": "assets/models/alloywheel+10.glb",
    "allowheel04": "assets/models/alloywheel+14.glb",
    "allowheel05": "assets/models/alloywheel+14.glb",
    "headlight": "assets/models/headlight.glb",
    "spoiler3": "assets/models/Spoiler+01.glb",
    "spoiler 7": "assets/models/spolier+4.glb",
    "spoiler2": "assets/models/spolier++02.glb",
  };

  final Map<String, Map<String, String>> itemDetails = {
    "allowheel01": {
      "name": "Alloy Wheel Pro",
      "price": "LKR 60,000",
      "rating": "4.4 ⭐",
      "size": "16 inch",
    },
    "allowheel02": {
      "name": "Alloy Wheel Sport",
      "price": "LKR 75,000",
      "rating": "4.2 ⭐",
      "size": "15 inch",
    },
    "allowheel04": {
      "name": "Alloy Wheel X",
      "price": "LKR 88,000",
      "rating": "4.5 ⭐",
      "size": "17 inch",
    },
    "headlight": {
      "name": "LED Headlight",
      "price": "LKR 20,000",
      "rating": "4.3 ⭐",
      "size": "Standard",
    },
    "spoiler3": {
      "name": "Compact Spoiler",
      "price": "LKR 55,000",
      "rating": "4.4 ⭐",
      "size": "Small",
    },
    "spoiler 7": {
      "name": "Sport Spoiler",
      "price": "LKR 70,000",
      "rating": "4.1 ⭐",
      "size": "Medium",
    },
    "spoiler2": {
      "name": "Racing Spoiler",
      "price": "LKR 62,000",
      "rating": "4.6 ⭐",
      "size": "Medium",
    },
  };

  final Set<String> lockedItems = {
    "assets/modificationpart/alloywheel03.jpeg",
    "assets/modificationpart/allowheel05.jpeg",
    "assets/modificationpart/headlight01.jpg",
    "assets/modificationpart/headlight02.jpg",
    "assets/modificationpart/headlight03.jpg",
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

  Map<String, String>? getDetails(String imagePath) {
    for (var entry in itemDetails.entries) {
      if (imagePath.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }

  void showDetailsPopup(String imagePath) {
    final details = getDetails(imagePath);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagePath, height: 120),
                const SizedBox(height: 10),
                Text(
                  details?["name"] ?? "Item",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text("Price: ${details?["price"] ?? "-"}"),
                Text("Rating: ${details?["rating"] ?? "-"}"),
                Text("Size: ${details?["size"] ?? "-"}"),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showModificationPopup(String imagePath) {
    if (lockedItems.contains(imagePath)) return;

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
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDetailsPopup(imagePath);
                          },
                          child: const Text("Details"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            String modelPath = imageToModel.entries
                                .firstWhere(
                                  (entry) =>
                                      imagePath.contains(entry.key),
                                  orElse: () =>
                                      const MapEntry("", ""),
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
          "assets/modificationpart/headlight01.jpg",
          "assets/modificationpart/headlight02.jpg",
          "assets/modificationpart/headlight03.jpg",
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

  Widget buildLockedOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.4),
          ],
        ),
      ),
      child: Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.lock, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text(
                "LOCKED",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = getImages();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              height: 56,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                ),
              ),
              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                  "Hatchback Models",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 16),
              child: Text("Type a car model"),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(16),
              child: TextField(
                controller: carModelController,
                decoration:
                    const InputDecoration(
                  hintText:
                      "Eg: Honda Fit",
                  border:
                      OutlineInputBorder(),
                ),
                onChanged: (_) {
                  setState(() {
                    showModifications = false;
                  });
                },
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 16),
              child:
                  Text("Select the Parts"),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(16),
              child:
                  DropdownButtonFormField<
                      String>(
                value: selectedPart,
                hint: const Text(
                    "Select modification part"),
                items: const [
                  DropdownMenuItem(
                      value: "headlights",
                      child:
                          Text("Headlights")),
                  DropdownMenuItem(
                      value: "alloywheels",
                      child:
                          Text("Alloy Wheels")),
                  DropdownMenuItem(
                      value: "spoiler",
                      child:
                          Text("Spoiler")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedPart = value;
                    showModifications =
                        false;
                  });
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                      horizontal: 16),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(
                          double.infinity,
                          50),
                  backgroundColor:
                      Colors.orange,
                ),
                onPressed: isFormValid
                    ? () {
                        setState(() {
                          showModifications =
                              true;
                        });
                      }
                    : null,
                child:
                    const Text("Search"),
              ),
            ),
            const SizedBox(height: 10),
            if (showModifications)
              Expanded(
                child:
                    GridView.builder(
                  padding:
                      const EdgeInsets.all(
                          16),
                  itemCount:
                      images.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2,
                    crossAxisSpacing:
                        10,
                    mainAxisSpacing:
                        10,
                  ),
                  itemBuilder:
                      (context, index) {
                    final imagePath =
                        images[index];
                    final isLocked =
                        lockedItems
                            .contains(
                                imagePath);

                    return GestureDetector(
                      onTap: () {
                        if (!isLocked) {
                          showModificationPopup(
                              imagePath);
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(
                                      10),
                              border: Border.all(
                                  color: Colors
                                      .grey),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                      10),
                              child:
                                  Image.asset(
                                imagePath,
                                fit: BoxFit
                                    .cover,
                                width: double
                                    .infinity,
                                height: double
                                    .infinity,
                              ),
                            ),
                          ),
                          if (isLocked)
                            buildLockedOverlay(),
                        ],
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