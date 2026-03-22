import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String userId;
  final String vehicleType;
  final String vehicleModel;
  final String vehicleRegNo;

  const ProfilePage({
    super.key,
    required this.fullName,
    required this.email,
    required this.userId,
    this.vehicleType = "",
    this.vehicleModel = "",
    this.vehicleRegNo = "",
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController vehicleTypeController;
  late TextEditingController vehicleModelController;
  late TextEditingController vehicleRegController;

  bool isSaving = false;
  bool isEditing = false; // toggle btn

  @override
  void initState() {
    super.initState();
    vehicleTypeController = TextEditingController(text: widget.vehicleType);
    vehicleModelController = TextEditingController(text: widget.vehicleModel);
    vehicleRegController = TextEditingController(text: widget.vehicleRegNo);
  }

  @override
  void dispose() {
    vehicleTypeController.dispose();
    vehicleModelController.dispose();
    vehicleRegController.dispose();
    super.dispose();
  }

  Future<void> saveVehicleDetails() async {
    setState(() => isSaving = true);

    try {
      final url =
          Uri.parse("http://192.168.8.196:5000/api/auth/update-vehicle");

      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "userId": widget.userId,
              "vehicleType": vehicleTypeController.text.trim(),
              "vehicleModel": vehicleModelController.text.trim(),
              "vehicleRegNo": vehicleRegController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 10));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Vehicle details updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
        setState(() => isEditing = false); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Failed to update"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error updating vehicle: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  Widget _editableCard(String title, TextEditingController controller) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: TextField(
          controller: controller,
          enabled: isEditing, 
          decoration: InputDecoration(
            hintText: "Enter value",
            border: isEditing ? const UnderlineInputBorder() : InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Text(
          value.isEmpty ? "Not set" : value,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
            title: const Text(
              "My Profile",
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold, 
                fontSize: 20, 
              ),
            ),
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(
            color: Colors.white, 
            ), 
          ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(widget.fullName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            // Text(widget.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Vehicle Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          if (isEditing) {
                            saveVehicleDetails();
                          } else {
                            setState(() => isEditing = true);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isEditing ? Colors.green : Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(isEditing ? "Save" : "Edit"),
                )
              ],
            ),
            const SizedBox(height: 10),
            _editableCard("Vehicle Type", vehicleTypeController),
            _editableCard("Model", vehicleModelController),
            _editableCard("Vehicle Reg No", vehicleRegController),

            const SizedBox(height: 30),

            /// Personal Details RO
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Personal Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _infoCard("Full Name", widget.fullName),
            _infoCard("Email", widget.email),
          ],
        ),
      ),
    );
  }
}