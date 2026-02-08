import 'package:flutter/material.dart';

class SedanModel extends StatelessWidget {
  const SedanModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [

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

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: Text(
                "Sedan Models",
                style: TextStyle(
                  color: Color.fromARGB(179, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 12),
              child: Text(
                "Type a car model",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Eg: Toyota Corolla",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const Expanded(
              child: Center(),
            ),
          ],
        ),
      ),
    );
  }
}