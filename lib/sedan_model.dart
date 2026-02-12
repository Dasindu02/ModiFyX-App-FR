import 'package:flutter/material.dart';

class SedanModel extends StatefulWidget {
  const SedanModel({super.key});

  @override
  State<SedanModel> createState() => _SedanModelState();
}

class _SedanModelState extends State<SedanModel> {

  String? selectedPart;

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

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 12),
              child: Text(
                "Select the Parts",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select modification part"),
                    items: const [
                      DropdownMenuItem(
                        value: "headlights",
                        child: Text("Headlights"),
                      ),
                      DropdownMenuItem(
                        value: "alloywheels",
                        child: Text("Alloy Wheels"),
                      ),
                      DropdownMenuItem(
                        value: "spoiler",
                        child: Text("Spoiler"),
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                
                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          final car = carModelController.text.trim();
                          final part = selectedPart!;

                          // For now just print
                          debugPrint("Search pressed: $car , $part");

                          // Later you will navigate to result / AR page here
                        }
                      : null,
                  child: const Text("Search"),
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