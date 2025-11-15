import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color baseColor;
  final double? width;
  final double? height;

  const GlassContainer({
    Key? key,
    this.child,
    this.blur = 15, // Increased default blur for strong effect
    this.opacity = 0.15, // Slightly increased opacity
    this.borderRadius = 20, // Slightly more rounded
    this.baseColor = Colors.white,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        // The core blur effect
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // Semi-Transparent Background Color (The "glass" color)
            color: baseColor.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            // The subtle light border
            border: Border.all(
              color: baseColor.withOpacity(0.3),
              width: 1.5,
            ),
            // Subtle Shadow for lift
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}