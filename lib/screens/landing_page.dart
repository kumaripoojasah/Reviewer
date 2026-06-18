
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/loginscreen.dart';

// ---------------------------------------------------------------- //
// 🌟 1️⃣ Shining Logo Widget
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
    final Widget logoWidget = Center(
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
          shaderCallback: (bounds) =>
              gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: logoWidget,
        );
      },
    );
  }
}

// ---------------------------------------------------------------- //
// 💎 2️⃣ Glass Landing Page
// ---------------------------------------------------------------- //
class GlassLandingPage extends StatefulWidget {
  const GlassLandingPage({super.key});

  @override
  State<GlassLandingPage> createState() => _GlassLandingPageState();
}

class _GlassLandingPageState extends State<GlassLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background Image (FadeInImage)
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/final_land1.jpg', // local image
              image: 'https://picsum.photos/1600/900', // replace with your real image
              fit: BoxFit.cover,
            ),
          ),

          /// 🌫 Overlay
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.08),
            ),
          ),

          /// 🪩 SCROLLABLE CONTENT
          Center(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🧠 Heading
                      Text(
                        'AI Companion',
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 5),

                      Text(
                        'Smart. Simple. Seamless.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// 🤖 3D Model
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
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// ✨ Logo
                      const ShiningLogo(),

                      const SizedBox(height: 30),

                      /// 🚀 Button
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
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                color: Colors.white.withOpacity(0.08),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ✨ Bottom line
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



