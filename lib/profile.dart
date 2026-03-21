import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String fullName;
  final String email;

  const ProfilePage({
    super.key,
    required this.fullName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// Profile Image
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 12),

            /// Name
            Text(
              fullName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            /// Email
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// ---------------- Vehicle Details ----------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Vehicle Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            _infoCard("Vehicle Type", "Sedan"),
            _infoCard("Model", "Toyota Axio"),
            _infoCard("Color", "White"),

            const SizedBox(height: 20),

            /// ---------------- Personal Details ----------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Personal Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            _infoCard("Full Name", fullName),
            _infoCard("Email", email),
          ],
        ),
      ),
    );
  }

  
  Widget _infoCard(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}