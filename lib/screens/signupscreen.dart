import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../glass_container.dart';
import '../widgets/auth_background.dart';
import '../screens/home_screen.dart';
import '../mobile/auth_service.dart'; // ✅ Make sure this path is correct

final AuthService _authService = AuthService();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // Controllers for inputs
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
   static final TextEditingController phoneController = TextEditingController();
  // Reusable input decoration for the glass effect
  InputDecoration _glassInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      fillColor: Colors.white.withOpacity(0.05),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthBackground(
      child: GlassContainer(
        width: size.width * 0.9,
        baseColor: Colors.grey.shade900,
        opacity: 0.15,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Full Name
                TextField(
                  controller: nameController,
                  decoration: _glassInputDecoration("Full Name"),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
               
                TextField(
                  controller: phoneController,
                  decoration: _glassInputDecoration("Phone Number"),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _glassInputDecoration("Email"),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _glassInputDecoration("Password"),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),

                // ✅ Sign Up button with Firebase Auth
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // Call AuthService signup
                      await _authService.signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      // ✅ Update username in Firebase profile
                      await _authService.updateUsername(
                        username: nameController.text.trim(),
                      );

                      // Navigate to home page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Signup failed: $e"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ",
                        style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


