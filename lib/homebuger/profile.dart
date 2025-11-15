import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: const Color(0xFF1a1a2e), // Dark background for theme consistency
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 60, color: Colors.lightBlueAccent),
            const SizedBox(height: 20),
            Text(
              'Profile Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Name, Email, and account management options.',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1a1a2e), // Match the dark theme
    );
  }
}