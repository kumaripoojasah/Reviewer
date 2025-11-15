

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom text styles

// This is the file your splash screen will navigate to.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // A global key is needed to open the drawer from the app bar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // This allows the body's background image to go behind the app bar
      extendBodyBehindAppBar: true,

      // --- Custom App Bar ---
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          // You must add 'assets/images/hp_logo.png'
          child: Image.asset('Aura.png'),
        ),
        actions: [
          // --- Login Button ---
         
          const SizedBox(width: 8),

          // --- Hamburger Menu Button ---
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open the drawer (defined below)
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- Hamburger Menu Drawer ---
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1a1a2e),
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Hackfest Menu'),
            ),
            ListTile(title: const Text('Home'), onTap: () {}),
            ListTile(title: const Text('About'), onTap: () {}),
            ListTile(title: const Text('Tracks'), onTap: () {}),
            ListTile(title: const Text('Sponsors'), onTap: () {}),
            ListTile(title: const Text('Login'), onTap: () {}),
          ],
        ),
      ),

      // --- Chat Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Handle chat action
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),

      // --- Page Body ---
      body: Stack(
        children: [
          // --- Background Image & Overlay ---
          // This container sits at the bottom of the stack
          _buildBackgroundImage(),

          // --- Scrollable Content ---
          // This sits on top of the background image
          SingleChildScrollView(
            child: Column(
              children: [
                // Spacer to push content below the transparent app bar
                SizedBox(height: kToolbarHeight + 40),

                // --- ABOUT SECTION ---
                _buildAboutSection(),

                const SizedBox(height: 60),

                // --- SPONSORS SECTION ---
                _buildSponsorsSection(),

                const SizedBox(height: 60),

                // --- TRACKS SECTION ---
                _buildTracksSection(),

                // Bottom padding
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Background Widget ---
  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // You must add 'assets/images/background.jpg'
          image: const AssetImage('assets/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      // Dark overlay for better text readability
      child: Container(
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  // --- "About" Section Widget ---
  Widget _buildAboutSection() {
    // This is the custom font style.
    // Replace 'YourCustomFont' with the name defined in pubspec.yaml
    const textStyle = TextStyle(
      fontFamily: 'YourCustomFont', // <-- ASSUMED CUSTOM FONT
      fontSize: 48,
      color: Colors.white,
    );

    return Column(
      children: [
        const Text('About', style: textStyle),
        const SizedBox(height: 20),

        // This container simulates the "stone tablet"
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white30),
          ),
          child: Column(
            children: [
              // --- Top Row ---
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'April\n18th 19th 20th',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Text(
                    'Revive\nThe\nLost Tech',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, height: 1.5),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- Middle Logo ---
              // You must add 'assets/images/hf_logo_grey.png'
              Image.asset(
                'assets/3d_robo.png',
                height: 80,
                color: Colors.white70,
              ),
              const SizedBox(height: 20),

              // --- Bottom Text ---
              const Text(
                '3 Day Long Tech-Fest',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- "Sponsors" Section Widget ---
  Widget _buildSponsorsSection() {
    // Re-use the "About" font style
    const titleStyle = TextStyle(
      fontFamily: 'YourCustomFont', // <-- ASSUMED CUSTOM FONT
      fontSize: 40,
      color: Colors.white,
    );

    return Column(
      children: [
        const Text('Presented By', style: titleStyle),
        const SizedBox(height: 16),
        // You must add 'assets/images/nitte_logo.png'
        Image.asset('assets/3d_robo.png', height: 70),

        const SizedBox(height: 40),
        const Text('Powered By', style: titleStyle),
        const SizedBox(height: 16),
        // You must add 'assets/images/paloalto_logo.png'
        Image.asset('assets/3d_robo.png', height: 50),
        const SizedBox(height: 24),
        // You must add 'assets/images/inflow_logo.png'
        Image.asset('assets/3d_robo.png', height: 60),

        const SizedBox(height: 40),
        const Text('Co-Powered By', style: titleStyle),
        // Add more sponsor logos here...
      ],
    );
  }

  // --- "Tracks" Section Widget ---
  Widget _buildTracksSection() {
    const titleStyle = TextStyle(
      fontFamily: 'YourCustomFont', // <-- ASSUMED CUSTOM FONT
      fontSize: 48,
      color: Colors.white,
    );

    return Column(
      children: [
        const Text('Tracks', style: titleStyle),
        const SizedBox(height: 20),

        // Wrap is great for responsive grids
        Wrap(
          spacing: 16, // Horizontal space between cards
          runSpacing: 16, // Vertical space between cards
          alignment: WrapAlignment.center,
          children: [
            // --- Track Cards ---
            // These are just the images. You must add them to assets.
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
          ],
        ),
      ],
    );
  }

  // Helper widget for a track card
  Widget _buildTrackCard(String imagePath) {
    // In your screenshots, the cards are just images with text baked in
    return SizedBox(
      width: 170, // Adjust size as needed
      height: 170,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom text styles
import '../homebuger/about.dart';
import '../homebuger/history.dart';
import '../homebuger/profile.dart';



// Placeholder Pages (You should replace these with your actual files)
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('History')), body: const Center(child: Text('History Page Content')));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Profile')), body: const Center(child: Text('Profile Page Content')));
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('About')), body: const Center(child: Text('About Page Content')));
  }
}

// ⚠️ You will need to create a new page for the output, e.g., 'OutputPage.dart'
class OutputPage extends StatelessWidget {
  final String inputData;
  const OutputPage({super.key, required this.inputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Output')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text('Received Input:\n\n$inputData'),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _inputController = TextEditingController();
  String _selectedInputType = 'JSON';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  // --- New Logic: Generate Button Action ---
  void _handleGenerate() {
    final inputData = _inputController.text.trim();

    if (inputData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter data to generate output.")),
      );
      return;
    }

    // Navigate to the next page, passing the input data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutputPage(inputData: inputData),
      ),
    );
  }

  // --- New Logic: Drawer Navigation ---
  void _navigateTo(Widget page) {
    // Close the drawer before navigating
    Navigator.pop(context);
    // Navigate to the new page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      hintText: 'Enter $_selectedInputType, Text, or CSV data here...',
      hintStyle: TextStyle(color: Colors.white54),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      fillColor: Colors.black.withOpacity(0.5),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      
      // --- Custom App Bar ---
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          // Using a corrected asset path for the logo
          child: Image.asset('Aura.png'), 
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
      ),*/
      appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.all(8.0), // Reduced padding slightly to give more room
    child: SizedBox(
      // 🌟 ADDED SizedBox to control the size 🌟
      height: 80, // Adjust the desired height (e.g., from default ~24 to 40)
      width: 60,  // Adjust the desired width
      child: Image.asset(
        'Aura.png', 
        fit: BoxFit.contain, // Ensures the image fits within the new bounds
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

      // --- Updated Hamburger Menu Drawer ---
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1a1a2e),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1a1a2e),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application Menu',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Navigation & Settings', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            // ✅ Profile Icon & Link
            ListTile(
              leading: const Icon(Icons.person, color: Colors.lightBlueAccent),
              title: const Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const ProfilePage()),
            ),
            // ✅ History Icon & Link
            ListTile(
              leading: const Icon(Icons.history, color: Colors.lightBlueAccent),
              title: const Text('History', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const HistoryPage()),
            ),
            // ✅ About Icon & Link
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.lightBlueAccent),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () => _navigateTo(const AboutPage()),
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                // TODO: Implement actual logout logic
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),

      // --- Chat Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Handle chat action
        },
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),

      // --- Page Body ---
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 40),

                // 🌟 MODIFIED: INPUT GENERATION SECTION 🌟
                _buildInputGenerationSection(context),

                const SizedBox(height: 60),

                // --- SPONSORS SECTION --- (Kept for continuity)
                _buildSponsorsSection(),

                const SizedBox(height: 60),

                // --- TRACKS SECTION --- (Kept for continuity)
                _buildTracksSection(),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 NEW WIDGET: Input and Generate Section 🌟
  Widget _buildInputGenerationSection(BuildContext context) {
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
              // --- Input Type Dropdown (Optional) ---
              DropdownButtonFormField<String>(
                decoration: _inputDecoration("Input Type"),
                value: _selectedInputType,
                items: ['JSON', 'TEXT', 'CSV']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedInputType = value!;
                  });
                },
                dropdownColor: Colors.black.withOpacity(0.8),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // --- Text Area for Input ---
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.multiline,
                maxLines: 8, // Make it a proper textarea
                decoration: _inputDecoration("Enter Data"),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),

              // --- Generate Button ---
              ElevatedButton.icon(
                onPressed: _handleGenerate,
                icon: const Icon(Icons.send_rounded),
                label: const Text(
                  'GENERATE OUTPUT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // --- Background Widget (Path updated to 'assets/home.jpg') ---
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

  // --- "Sponsors" Section Widget (Kept from original) ---
  Widget _buildSponsorsSection() {
    // Re-use the "About" font style
    const titleStyle = TextStyle(
      fontFamily: 'YourCustomFont', // <-- ASSUMED CUSTOM FONT
      fontSize: 40,
      color: Colors.white,
    );
return Column(
  children: [
    Text(
      'Presented By',
      style: GoogleFonts.poppins(      // Using Poppins from Google Fonts
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 209, 205, 214),
        letterSpacing: 1.2,
      ),
    ),
    const SizedBox(height: 16),
    Text(
      'Aura',
      style: GoogleFonts.lobster(      // Stylish cursive font
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.purple.shade100,
      ),
    ),

    const SizedBox(height: 40),
    Text(
      'Powered By',
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color:const Color.fromARGB(255, 209, 205, 214),
        letterSpacing: 1.2,
      ),
    ),
    const SizedBox(height: 16),
    Text(
      'Aura',
      style: GoogleFonts.lobster(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.purple.shade100,
      ),
    ),
  ],
);
    /*return Column(
      children: [
        const Text('Presented By', style: titleStyle),
        const SizedBox(height: 16),
        // Placeholder image
        Image.asset('assets/3d_robo.png', height: 70),

        const SizedBox(height: 40),
        const Text('Powered By', style: titleStyle),
        const SizedBox(height: 16),
        // Placeholder image
        Image.asset('assets/3d_robo.png', height: 50),
        const SizedBox(height: 24),
        // Placeholder image
        Image.asset('assets/3d_robo.png', height: 60),

        const SizedBox(height: 40),
        const Text('Co-Powered By', style: titleStyle),
        // Add more sponsor logos here...
      ],
    );
  }*/
  /*return Column(
  children: [
    const Text('Presented By', style: titleStyle),
    const SizedBox(height: 16),
    // Placeholder text instead of image
    const Text('Aura', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.deepPurple)),

    const SizedBox(height: 40),
    const Text('Powered By', style: titleStyle),
    const SizedBox(height: 16),
    // Placeholder text instead of image
    const Text('Aura', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.pinkAccent)),

    /*const SizedBox(height: 24),
    // Another placeholder text
    const Text('Aura', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.teal)),

    //const SizedBox(height: 40),
    //const Text('Co-Powered By', style: titleStyle),
    // Add more sponsor names as Text widgets here...*/
  ],
);*/
  
 }

  // --- "Tracks" Section Widget (Kept from original) ---
  Widget _buildTracksSection() {
    const titleStyle = TextStyle(
      fontFamily: 'YourCustomFont', // <-- ASSUMED CUSTOM FONT
      fontSize: 48,
      color: Colors.white,
    );

    return Column(
      children: [
        const Text('Tracks', style: titleStyle),
        const SizedBox(height: 20),

        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            // Placeholder track cards
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
            _buildTrackCard('assets/3d_robo.png'),
          ],
        ),
      ],
    );
  }

  // Helper widget for a track card
  Widget _buildTrackCard(String imagePath) {
    return SizedBox(
      width: 170,
      height: 170,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}