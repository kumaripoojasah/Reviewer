// ❗ ADD THESE IMPORTS AT THE TOP
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/OutputPage.dart'; // We'll re-use your output page!
// ------------------------------------

import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = false;

  // --- 🌟 NEW LOGIC: Call the /product-report endpoint ---
  Future<void> _fetchProductReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Define your backend URL for this specific endpoint
      final url = Uri.parse('http://127.0.0.1:8080/product-report');
      
      // 2. This is a POST request, but we send JSON, not a file
      final response = await http.post(
        url,
        // 3. Send the product name as JSON
        body: json.encode({
          'product': 'Samsung S23 Review' // This matches your backend's hard-coded file
        }),
        // 4. Tell the server we're sending JSON
        headers: {
          'Content-Type': 'application/json',
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Success!
        final Map<String, dynamic> responseData = json.decode(response.body);

        // 5. Navigate to the SAME OutputPage as before
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OutputPage(analysisData: responseData),
          ),
        );
      } else {
        // Handle backend errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error ${response.statusCode}: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle network errors
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to connect to server: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History & Reports')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Generate a pre-saved report:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchProductReport,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Get Samsung S23 Report'),
            ),
          ],
        ),
      ),
    );
  }
}