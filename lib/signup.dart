import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool agreeToTerms = false;
  bool isLoading = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /// 🔗 CHANGE THIS to your backend URL
  final String baseUrl = "http://192.168.8.196:5000/api/auth/register";

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      showMessage("Passwords do not match");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": fullNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "createdBy": "APP",
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showMessage("Account created successfully ✅");
        Navigator.pop(context);
      } else {
        showMessage(data["message"] ?? "Signup failed");
      }
    } catch (e) {
      showMessage("Server error");
    }

    setState(() => isLoading = false);
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              height: 530,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Get Started',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),

                    buildInput(
                      controller: fullNameController,
                      label: "Full Name",
                      hint: "Enter Full Name",
                    ),
                    const SizedBox(height: 16),

                    buildInput(
                      controller: emailController,
                      label: "Email",
                      hint: "Enter Email",
                    ),
                    const SizedBox(height: 16),

                    buildInput(
                      controller: passwordController,
                      label: "Password",
                      hint: "Enter Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),

                    buildInput(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Confirm Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                    /// Terms
                    Row(
                      children: [
                        Checkbox(
                          value: agreeToTerms,
                          onChanged: (v) =>
                              setState(() => agreeToTerms = v ?? false),
                        ),
                        const Expanded(
                          child: Text(
                            "I agree to the Terms & Conditions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:
                            agreeToTerms && !isLoading ? signUp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Back Button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
