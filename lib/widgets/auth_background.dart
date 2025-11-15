import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensure content can extend behind the app bar area if needed
      extendBodyBehindAppBar: true, 
      body: Stack(
        children: [
          // 1. Background Image (The dark, textured image)
          Positioned.fill(
            child: Image.asset(
              'assets/back_astro.jpg', // Your chosen path
              fit: BoxFit.cover,
            ),
          ),
          
          // 2. The form content (Login or Sign Up) centered on the screen
          Center(
            child: child,
          ),
        ],
      ),
    );
  }
}