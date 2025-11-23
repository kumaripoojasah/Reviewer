/*import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

/// 🌟 1️⃣ Shining Logo Widget
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _shineDuration,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can also replace this Text with Image.asset('assets/veritas_logo.png')
   /* final Widget logoWidget = Text(
      'VERITAS',
      style: GoogleFonts.poppins(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 3,
      ),
    );final Widget logoWidget = Image.asset(
      'assets/veritas_logo.png', // 🔹 your logo path
      height: 120, // adjust as needed
      width: 200,
      fit: BoxFit.contain,
    );*/
    final Widget logoWidget = LayoutBuilder(
  builder: (context, constraints) {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -10), // 👈 moves logo slightly upward
        child: FractionallySizedBox(
          widthFactor: 0.6, // 👈 adjust 0.1 → 1.0 for size control
          child: Image.asset(
            'assets/veritas_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  },
);


    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [
            offset - 1.0,
            offset,
            offset + 1.0,
          ],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) =>
              gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

/// 💎 2️⃣ Glass Landing Page
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              /// 🖼 Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/final_land1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 🌫 Transparent overlay (no blur, just subtle glass tint)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),

              /// 🪩 Foreground 3D model + Shining Logo
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 380,
                      height: 400,
                      child: ModelViewer(
                        backgroundColor: Colors.transparent,
                        src: 'assets/glass_head.glb',
                        autoRotate: true,
                        cameraControls: true,
                        autoPlay: true,
                        disableZoom: false,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ✨ Shining Logo below 3D model
                    const ShiningLogo(),
                  ],
                ),
              ),

              /// 🧠 Headings + Subheading
             /* Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'AI Companion',
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Smart. Simple. Seamless.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  */

              /// 🧍 Get Started button (Glass style)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: InkWell(
                        onTap: () {
                          // TODO: Add navigation here
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                            color: Colors.white.withOpacity(0.08),
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// ✨ Bottom reflection line
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}-----
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart'; // ✅ added import for navigation

/// 🌟 1️⃣ Shining Logo Widget
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _shineDuration,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/veritas_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [
            offset - 1.0,
            offset,
            offset + 1.0,
          ],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) =>
              gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

/// 💎 2️⃣ Glass Landing Page
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              /// 🖼 Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/final_land1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 🌫 Transparent overlay (soft glass tint)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),

              /// 🪩 Foreground 3D model + Shining Logo
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 380,
                      height: 400,
                      child: ModelViewer(
                        backgroundColor: Colors.transparent,
                        src: 'assets/glass_head.glb',
                        autoRotate: true,
                        cameraControls: true,
                        autoPlay: true,
                        disableZoom: false,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ✨ Shining Logo below 3D model
                    const ShiningLogo(),
                  ],
                ),
              ),

              /// 🧍 Get Started button (Glass style)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: InkWell(
                        onTap: () {
                          /// ✅ Navigate to Login Screen
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const LoginScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 800),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                            color: Colors.white.withOpacity(0.08),
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// ✨ Bottom reflection line
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}--- web
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shineDuration)..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: Image.asset(
              'assets/veritas_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [offset - 1.0, offset, offset + 1.0],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/final_land1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Glass overlay
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.08)),
          ),

          // Main scrollable content
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Model Viewer
                    Flexible(
                      flex: 6,
                      child: SizedBox(
                        width: size.width * 0.6, // 60% width
                        height: size.height * 0.5, // 50% height
                        child: ModelViewer(
                          backgroundColor: Colors.transparent,
                          src: 'assets/glass_head.glb',
                          autoRotate: true,
                          cameraControls: true,
                          autoPlay: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Logo
                    const Flexible(flex: 2, child: ShiningLogo()),

                    const Spacer(),

                    // Get Started button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      const LoginScreen(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5),
                                color: Colors.white.withOpacity(0.08),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}--- last

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

// ---------------------------------------------------------------- //
// 🌟 1️⃣ Shining Logo Widget (No changes needed here)
// ---------------------------------------------------------------- //
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shineDuration)..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: Keep the Transform.translate here if you want the slight upward shift
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/veritas_logo.png', // Ensure this path is correct
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [offset - 1.0, offset, offset + 1.0],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

// ---------------------------------------------------------------- //
// 💎 2️⃣ Glass Landing Page (Modifications Applied)
// ---------------------------------------------------------------- //
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation for 3D model (if it's not handled internally by ModelViewer)
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/final_land1.jpg'), // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🌫 Transparent overlay (soft glass tint)
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.08)),
          ),

          /// 🪩 Main Content (Center + Scrollable for safety)
          Center(
            child: SingleChildScrollView(
              // Added SingleChildScrollView for better web/desktop handling
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0), // Outer padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🧠 Headings + Subheading (Re-added for complete layout)
                    Text(
                      'AI Companion',
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.95),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Smart. Simple. Seamless.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// 3D Model Viewer
                    SizedBox(
                      // Used fixed size as ModelViewer can be tricky with Flexible/Expanded
                      width: 380, 
                      height: 400,
                      child: ModelViewer(
                        backgroundColor: Colors.transparent,
                        src: 'assets/glass_head.glb', // Ensure this path is correct
                        autoRotate: true,
                        cameraControls: true,
                        autoPlay: true,
                        disableZoom: false,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ✨ Shining Logo
                    const ShiningLogo(),
                    const SizedBox(height: 50), // Increased space before button

                    /// 🧍 Get Started button (Glass style)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const LoginScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                transitionDuration: const Duration(milliseconds: 800),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50), // Space for bottom line
                  ],
                ),
              ),
            ),
          ),

          /// ✨ Bottom reflection line (aligned bottom of Stack)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
/*
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

// ---------------------------------------------------------------- //
// 🌟 1️⃣ Shining Logo Widget (Kept as is for brevity)
// ---------------------------------------------------------------- //
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shineDuration)
      ..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/Aura.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [offset - 1.0, offset, offset + 1.0],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

// ---------------------------------------------------------------- //
// 💎 2️⃣ Glass Landing Page (CORRECTED LAYOUT)
// ---------------------------------------------------------------- //
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive sizing
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background Image & Overlay (Fixed layers)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/final_land1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.08)),
          ),

          /// 🪩 SCROLLABLE MAIN CONTENT
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // Nice scroll feel
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Takes minimal vertical space
                  children: [
                    /// 🧠 Headings + Subheading (Aligned to the top of the content)
                    Text(
                      'AI Companion',
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.95),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Smart. Simple. Seamless.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// 3D Model Viewer
                    SizedBox(
                      width: size.width * 0.9, // Use a responsive width
                      height: size.height * 0.5, // Use a responsive height
                      child: ModelViewer(
                        backgroundColor: Colors.transparent,
                        src: 'assets/glass_head.glb',
                        ar: true,
                        autoRotate: true,
                        cameraControls: true,
                        autoPlay: true,
                        disableZoom: false,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ✨ Shining Logo
                    const ShiningLogo(),
                    const SizedBox(height: 50),

                    /// 🧍 Get Started button (Glass style)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const LoginScreen(),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    FadeTransition(opacity: animation, child: child),
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50), // Added spacing for bottom reflection line
                  ],
                ),
              ),
            ),
          ),

          /// ✨ Bottom reflection line (Aligned to the bottom of the Stack/Screen)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}----final

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

// ---------------------------------------------------------------- //
// 🌟 1️⃣ Shining Logo Widget (Kept as is for brevity)
// ---------------------------------------------------------------- //
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shineDuration)
      ..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: Image.asset(
                'assets/Aura.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [offset - 1.0, offset, offset + 1.0],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

// ---------------------------------------------------------------- //
// 💎 2️⃣ Glass Landing Page (MODIFIED LAYOUT FOR SCROLLBAR)
// ---------------------------------------------------------------- //
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController(); // Added ScrollController

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive sizing
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background Image & Overlay (Fixed layers)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/final_land1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.08)),
          ),

          /// 🪩 SCROLLABLE MAIN CONTENT (Wrapped in Scrollbar)
          Center(
            child: Scrollbar( // 👈 ADDED SCROLLBAR WIDGET
              controller: _scrollController,
              thumbVisibility: true, // Always show thumb on desktop
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController, // 👈 Assigned ScrollController
                physics: const BouncingScrollPhysics(), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      /// 🧠 Headings + Subheading
                      Text(
                        'AI Companion',
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Smart. Simple. Seamless.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 40),

                      /// 3D Model Viewer
                      SizedBox(
                        width: size.width * 0.9, 
                        height: size.height * 0.5, 
                        child: ModelViewer(
                          backgroundColor: Colors.transparent,
                          src: 'assets/glass_head.glb',
                          ar: true,
                          autoRotate: true,
                          cameraControls: true,
                          autoPlay: true,
                          disableZoom: false,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// ✨ Shining Logo
                      const ShiningLogo(),
                      const SizedBox(height: 50),

                      /// 🧍 Get Started button (Glass style)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => const LoginScreen(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(opacity: animation, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                color: Colors.white.withOpacity(0.08),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50), // Spacing below button
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ✨ Bottom reflection line (Aligned to the bottom of the Stack/Screen)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart'; // Ensure this path is correct

// ---------------------------------------------------------------- //
// 🌟 1️⃣ Shining Logo Widget (Handles the animated gradient text)
// ---------------------------------------------------------------- //
class ShiningLogo extends StatefulWidget {
  const ShiningLogo({super.key});

  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Duration _shineDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _shineDuration)
      ..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logoWidget = LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: Image.asset(
                'assets/Aura.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = _animation.value;
        final Gradient gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF6A0DAD),
            Color(0xFFE0B0FF),
            Color(0xFF6A0DAD),
          ],
          stops: [offset - 1.0, offset, offset + 1.0],
        );

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

// ---------------------------------------------------------------- //
// 💎 2️⃣ Glass Landing Page (Complete, Scrollable, and Compact Layout)
// ---------------------------------------------------------------- //
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController(); // Added ScrollController

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive sizing
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background Image & Overlay (Fixed layers)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/final_land1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.08)),
          ),

          /// 🪩 SCROLLABLE MAIN CONTENT (Wrapped in Scrollbar)
          Center(
            child: Scrollbar( // Explicit Scrollbar for better UX on web/desktop
              controller: _scrollController,
              thumbVisibility: true, 
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController, // Link controller
                physics: const BouncingScrollPhysics(), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Takes minimal vertical space
                    children: [
                      /// 🧠 Headings + Subheading
                      Text(
                        'AI Companion',
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 5), // MODIFIED: Reduced from 10
                      Text(
                        'Smart. Simple. Seamless.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 20), // MODIFIED: Reduced from 40

                      /// 3D Model Viewer
                      SizedBox(
                        // Keep responsive sizing using media query
                        width: size.width * 0.9, 
                        height: size.height * 0.5, 
                        child: ModelViewer(
                          backgroundColor: Colors.transparent,
                          src: 'assets/glass_head.glb',
                          ar: true,
                          autoRotate: true,
                          cameraControls: true,
                          autoPlay: true,
                          disableZoom: false,
                        ),
                      ),
                      const SizedBox(height: 10), // MODIFIED: Reduced from 16

                      /// ✨ Shining Logo
                      const ShiningLogo(),
                      const SizedBox(height: 30), // MODIFIED: Reduced from 50

                      /// 🧍 Get Started button (Glass style)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => const LoginScreen(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(opacity: animation, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                color: Colors.white.withOpacity(0.08),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50), // Padding below button
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ✨ Bottom reflection line (Fixed at the bottom of the screen)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



