// home.dart
import 'package:flutter/material.dart';
import 'sedan_model.dart';
import 'hatchback_model.dart';
import 'upload_car_images.dart';
import 'profile.dart';

class HomePage extends StatelessWidget {
  final String fullName;
  final String email;
  final String vehicleType;
  final String vehicleModel;
  final String vehicleRegNo;
  final String userId;

  const HomePage({
    super.key,
     required this.userId,
    required this.fullName,
    required this.email,
    this.vehicleType = "",
    this.vehicleModel = "",
    this.vehicleRegNo = "",
  });

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    final firstName = fullName.split(" ").first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- Top Bar ----------------
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "ModiFyX",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),

            // ---------------- Body ----------------
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "${getGreeting()} ! "),
                            TextSpan(
                              text: "$firstName,",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Visualize your car before you modify",
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Please select your vehicle type;",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // -------- Sedan Card --------
                      _vehicleCard(
                        image: "assets/images/sedan.jpg",
                        title: "Sedan",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SedanModel(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),

                      // -------- Hatchback Card --------
                      _vehicleCard(
                        image: "assets/images/hatchback.jpg",
                        title: "Hatchback",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HatchbackModel(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        "Popular Mods/ Trending;",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _ModItem(image: "assets/images/mod1.png"),
                          _ModItem(image: "assets/images/mod2.jpg"),
                          _ModItem(image: "assets/images/mod3.jpg"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ---------------- Bottom Bar ----------------
            Container(
              height: 60,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  // 3D Preview
                  IconButton(
                    icon: const Icon(Icons.view_in_ar),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UploadCarImages(),
                        ),
                      );
                    },
                  ),
                  // Cart
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {},
                  ),
                  // Profile
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            fullName: fullName,
                            email: email,
                            userId: userId,
                            vehicleType: vehicleType,
                            vehicleModel: vehicleModel,
                            vehicleRegNo: vehicleRegNo,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Vehicle card widget
Widget _vehicleCard({
  required String image,
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.asset(
            image,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 10,
            right: 12,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 6)],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Mod item widget
class _ModItem extends StatelessWidget {
  final String image;
  const _ModItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}