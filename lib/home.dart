import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String fullName;

  const HomePage({super.key, required this.fullName});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstName = fullName.split(" ").first;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              "${getGreeting()}, $firstName",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "Visualize your car before you modify",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 196, 2, 2),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
