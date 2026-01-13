import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back button
         
          // Bottom Card
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
               padding: const EdgeInsets.all(24),   
               height: 425,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                    children: [
                      const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 24),

                      TextField(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter Full Name',
                            floatingLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                         const SizedBox(height: 20),

                      TextField(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            floatingLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                         const SizedBox(height: 16),

                  // Password
                  TextField(
                    style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
              ),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Password',
                       floatingLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),

                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                        

                  ],
                ),
                
              ),
              
            ),
            

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
}
