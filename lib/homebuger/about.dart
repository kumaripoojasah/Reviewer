import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        backgroundColor: const Color(0xFF1a1a2e), // Dark background for theme consistency
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.info_outline, size: 60, color: Colors.lightBlueAccent),
              const SizedBox(height: 20),
              Text(
                'Application Name',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'This application is designed to process various data formats (JSON, TEXT, CSV) and generate meaningful output based on the input provided.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                '© 2025 Your Company/Project Name',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1a1a2e), // Match the dark theme
    );
  }
}