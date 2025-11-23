import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:intl/intl.dart'; // For date formatting

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- Controllers for text fields ---
  final TextEditingController _nameController = TextEditingController(text: 'Melissa Peters');
  final TextEditingController _emailController = TextEditingController(text: 'melpeters@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '**********'); // Placeholder for display
  final TextEditingController _dobController = TextEditingController(text: '23/05/1995'); // Placeholder for display
  final TextEditingController _countryController = TextEditingController(text: 'India'); // Placeholder for display

  // --- State variables for UI ---
  bool _obscurePassword = true;
  DateTime? _selectedDate; // To store the actual selected date

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  // --- Date Picker function ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(1995, 5, 23), // Default from image
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF0D47A1), // Dark blue primary color
              onPrimary: Colors.white,
              surface: Color(0xFF1A237E), // Darker blue surface
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1A237E),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  // --- Country/Region Selector (simple bottom sheet example) ---
  void _selectCountry(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Make background transparent
      builder: (BuildContext bc) {
        return ClipRRect( // Apply ClipRRect for rounded corners and blur
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Glassmorphism blur
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15), // Semi-transparent glass background
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Select Country/Region',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  ListTile(
                    title: const Text('India', style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      setState(() {
                        _countryController.text = 'India';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('United States', style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      setState(() {
                        _countryController.text = 'United States';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('United Kingdom', style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      setState(() {
                        _countryController.text = 'United Kingdom';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Reusable Input Field Widget ---
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none, // No border by default
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: const Color(0xFF4A90E2), width: 2.0), // Blue focus border
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Match background gradient
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true, // Allow body to extend behind app bar for seamless gradient
      body: Container(
        // Background gradient matching the image
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 150, 39, 215), // Darker blue at top
              Color.fromARGB(255, 99, 50, 109), // Medium blue
              Color(0xFF000000), // Black at bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0), // Adjust vertical for app bar
          child: Column(
            children: [
              // --- Profile Picture Section ---
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white.withOpacity(0.1), // Border effect
                    child: const CircleAvatar(
                      radius: 58,
                      backgroundImage: AssetImage('assets/profile_placeholder.jpeg'), // Replace with actual image asset
                      backgroundColor: Colors.grey, // Fallback background
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Handle profile picture change
                        print('Change profile picture');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2), // Transparent button background
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // --- Input Fields ---
              _buildInputField(
                label: 'Name',
                controller: _nameController,
              ),
              _buildInputField(
                label: 'Email',
                controller: _emailController,
                readOnly: true, // Emails are often read-only for security
              ),
              _buildInputField(
                label: 'Password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              _buildInputField(
                label: 'Date of Birth',
                controller: _dobController,
                readOnly: true, // Make it read-only so it can only be changed via the date picker
                onTap: () => _selectDate(context),
                suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
              ),
              _buildInputField(
                label: 'Country/Region',
                controller: _countryController,
                readOnly: true, // Make it read-only so it can only be changed via selector
                onTap: () => _selectCountry(context),
                suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
              ),

              const SizedBox(height: 30),

              // --- Save Changes Button ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save changes logic here
                    print('Name: ${_nameController.text}');
                    print('Email: ${_emailController.text}');
                    print('Password (encrypted): ${_passwordController.text}'); // In real app, send actual password if changed
                    print('Date of Birth: ${_dobController.text}');
                    print('Country: ${_countryController.text}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile changes saved!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2), // Bright blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Save changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ensure you have a placeholder image in your assets folder, e.g., 'assets/profile_placeholder.png'
// Or remove the backgroundImage and rely on backgroundColor: Colors.grey