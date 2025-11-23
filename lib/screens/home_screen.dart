// ❗ ADD THESE IMPORTS AT THE TOP
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
// ------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homebuger/about.dart';
import '../homebuger/history.dart';
import '../homebuger/profile.dart';
import 'dart:ui'; // For ImageFilter

// ❗ This is the new page we will create next
import '../screens/OutputPage.dart';

// --- Placeholder Pages (You can keep your real ones) ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: Text('Profile Page Content')));
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const Center(child: Text('History Page Content')));
  }
}

class AboutAura extends StatelessWidget {
  const AboutAura({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About')),
        body: const Center(child: Text('About Page Content')));
  }
}
// --------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // --- 🌟 NEW STATE VARIABLES ---
  FilePickerResult? _pickedFileResult;
  bool _isGenerating = false;
  // ---

  // --- 🌟 NEW LOGIC: File Picking ---
  Future<void> _pickFile() async {
    // This will open the file selector
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'json'], // Matches your backend
      withData: true, // This is crucial for web and mobile
    );

    if (result != null) {
      setState(() {
        _pickedFileResult = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected: ${result.files.first.name}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // User canceled the picker
    }
  }

  // --- 🌟 UPDATED LOGIC: Generate Button Action ---
  Future<void> _handleGenerate() async {
    if (_pickedFileResult == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select a file first."),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (_isGenerating) return; // Prevent double-taps

    setState(() {
      _isGenerating = true;
    });

    try {
      // 1. Get the file data from the picker
      final file = _pickedFileResult!.files.first;
      final fileBytes = file.bytes!;
      final fileName = file.name;

      // 2. Define your backend URL
      // ❗ (See "IMPORTANT" note below this code)
      final url = Uri.parse('http://127.0.0.1:8080/analyze');

      // 3. Create a "multipart" request (for sending files)
      var request = http.MultipartRequest('POST', url);

      // 4. Attach the file to the request
      // 'file' MUST match the key in your Flask code: request.files['file']
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
        ),
      );
      
      // 5. (Optional) Ask for the summary
      // This matches request.args.get('summarize') == 'true' in your Python
      request.fields['summarize'] = 'true';

      // 6. Send the request and wait for the response
      var streamedResponse = await request.send();

      // 7. Read and decode the response
      final response = await http.Response.fromStream(streamedResponse);

      setState(() {
        _isGenerating = false;
      });

      if (response.statusCode == 200) {
        // Success!
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Navigate to the OutputPage, passing the JSON data
        Navigator.push(
          context,
          MaterialPageRoute(
            // Pass the data to the new OutputPage
            builder: (context) => OutputPage(analysisData: responseData),
          ),
        );
      } else {
        // Handle backend errors
        String error = "Error ${response.statusCode}";
        try {
            final Map<String, dynamic> errorData = json.decode(response.body);
            error = errorData['error'] ?? 'Unknown backend error';
        } catch(e) {
            error = "$error: ${response.body.substring(0, 100)}...";
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle network errors (e.g., backend not running)
      setState(() {
        _isGenerating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to connect to server: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Drawer Navigation (Unchanged) ---
  void _navigateTo(Widget page) {
    Navigator.pop(context); // Close drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      
      // --- App Bar (Unchanged) ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            width: 60,
            child: Image.asset(
              'Aura.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- Drawer (Unchanged) ---
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1a1a2e),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF1a1a2e)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Application Menu',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Navigation & Settings',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.lightBlueAccent),
              title: const Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const ProfileScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.lightBlueAccent),
              title: const Text('History', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const HistoryPage()),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.lightBlueAccent),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const AboutAura()),
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // --- Chat Button (Unchanged) ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),

      // --- Page Body (Unchanged) ---
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 40),
                _buildInputGenerationSection(context), // 🌟 This widget is now updated
                const SizedBox(height: 60),
                _buildSponsorsSection(),
                const SizedBox(height: 60),
                _buildTracksSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 MODIFIED WIDGET: Input and Generate Section 🌟
  // This now uses the _pickFile method instead of a text field
  Widget _buildInputGenerationSection(BuildContext context) {
    // Get the selected file's name, or show a prompt
    final String fileName =
        _pickedFileResult?.files.first.name ?? "No file selected (.csv or .json)";

    return Column(
      children: [
        Text(
          'Data Input',
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- 1. Select File Button ---
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file, color: Colors.white70),
                label: const Text(
                  'SELECT FILE',
                  style: TextStyle(color: Colors.white70),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.4)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- 2. Show Selected File Name ---
              Text(
                fileName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 30),

              // --- 3. Generate Button (with loading) ---
              ElevatedButton.icon(
                onPressed: _isGenerating ? null : _handleGenerate,
                icon: _isGenerating
                    ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(
                  _isGenerating ? 'ANALYZING...' : 'GENERATE OUTPUT',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Unchanged Widgets (Sponsors, Tracks, Background) ---

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  Widget _buildSponsorsSection() {
    return Column(
      children: [
        Text('Presented By',
            style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 209, 205, 214),
                letterSpacing: 1.2)),
        const SizedBox(height: 16),
        Text('Aura',
            style: GoogleFonts.lobster(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade100)),
        const SizedBox(height: 40),
        Text('Powered By',
            style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 209, 205, 214),
                letterSpacing: 1.2)),
        const SizedBox(height: 16),
        Text('Aura',
            style: GoogleFonts.lobster(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade100)),
      ],
    );
  }

  final List<Map<String, dynamic>> trackData = [
    {'title': 'Feature Focus', 'icon': Icons.star_border, 'color': Colors.blueAccent},
    {'title': 'Customer Service', 'icon': Icons.support_agent, 'color': Colors.greenAccent},
    {'title': 'Emerging Trends', 'icon': Icons.trending_up, 'color': Colors.pinkAccent},
    {'title': 'Gap Finder', 'icon': Icons.search, 'color': Colors.orangeAccent},
  ];

  Widget _buildTracksSection() {
    const titleStyle = TextStyle(
        fontFamily: 'YourCustomFont', fontSize: 48, color: Colors.white);

    return Column(
      children: [
        const Text('Tracks', style: titleStyle),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ...trackData
                .map((data) => _buildGlassTrackCard(
                      data['title'] as String,
                      data['icon'] as IconData,
                      data['color'] as Color,
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassTrackCard(String title, IconData icon, Color color) {
    const double blur = 5.0;
    const double opacity = 0.15;

    return SizedBox(
      width: 170,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [
                        Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 2)
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}