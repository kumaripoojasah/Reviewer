import 'dart:ui';
import 'package:flutter/material.dart';

class AboutAura extends StatelessWidget {
  const AboutAura({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(   // ⭐ Entire page scrollable
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 146, 205, 213).withOpacity(0.15),
                  const Color.fromARGB(255, 182, 250, 255).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About the Application — AI-Powered Customer Review Insights Engine (Aura)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 3, 3),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  "Aura is a web-based intelligence system designed to help product teams make sense of massive volumes of customer reviews. Instead of relying only on star ratings, Aura digs deeper to uncover why customers feel the way they do.",
                  style: TextStyle(color: Color.fromARGB(179, 9, 6, 6), height: 1.5),
                ),

                SizedBox(height: 12),

                Text(
                  "The application ingests review datasets and uses Aspect-Based Sentiment Analysis (ABSA) to understand which specific product features—such as battery, camera, performance, pricing, delivery, or customer service—customers are talking about and the sentiment associated with each aspect.",
                  style: TextStyle(color: Color.fromARGB(179, 3, 2, 2), height: 1.5),
                ),

                SizedBox(height: 12),

                Text(
                  "The system automatically extracts aspects from raw review text and classifies the sentiment for each one as Positive, Negative, or Neutral. This transforms unstructured customer feedback into structured, actionable insights.",
                  style: TextStyle(color: Color.fromARGB(179, 8, 4, 4), height: 1.5),
                ),

                SizedBox(height: 12),

                Text(
                  "The web dashboard allows teams to upload review files, view the top praised and criticized features, and filter reviews by specific aspects to understand user pain points or strengths at a glance.",
                  style: TextStyle(color: Color.fromARGB(179, 20, 12, 12), height: 1.5),
                ),

                SizedBox(height: 12),

                Text(
                  "Aura enables product managers and decision-makers to identify hidden patterns in customer feedback, prioritize feature improvements, and track the real-world performance of their products—without manually reading thousands of reviews.",
                  style: TextStyle(color: Color.fromARGB(179, 20, 12, 12), height: 1.5),
                ),

                SizedBox(height: 12),

                Text(
                  "It delivers an end-to-end workflow: data input, intelligent analysis, and a clear visual summary that turns customer voices into meaningful product insights.",
                  style: TextStyle(color: Color.fromARGB(179, 8, 4, 4), height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
