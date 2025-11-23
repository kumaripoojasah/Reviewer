// ❗ Import the new charting library
import 'package:fl_chart/fl_chart.dart'; 
import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  final Map<String, dynamic> analysisData;

  const OutputPage({super.key, required this.analysisData});

  @override
  Widget build(BuildContext context) {
    // --- 1. Extract Data ---
    // We use '??' to provide safe fallback values
    final List topPraised = analysisData['top_praised'] ?? [];
    final List topCriticized = analysisData['top_criticized'] ?? [];
    final String summary = analysisData['summary'] ?? "No summary was generated.";
    
    // --- 2. Process Data for Charts ---
    // We calculate the TOTAL mentions to power the pie chart
    final double totalPositiveMentions = topPraised.fold(0, (sum, item) => sum + (item[1] as int));
    final double totalNegativeMentions = topCriticized.fold(0, (sum, item) => sum + (item[1] as int));
    final double totalMentions = totalPositiveMentions + totalNegativeMentions;

    // Check for no data to prevent division by zero
    final bool hasChartData = totalMentions > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis Results"),
        backgroundColor: const Color(0xFF1a1a2e),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1a1a2e),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Executive Summary (Unchanged) ---
            const Text(
              "Executive Summary",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24)
              ),
              child: Text(
                summary,
                style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),

            // --- 🌟 NEW CHART SECTION 🌟 ---
            if (hasChartData) ...[
              const Text(
                "Visual Insights",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              
              // We'll put the two charts side-by-side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 3. PIE CHART ---
                  Expanded(
                    flex: 2,
                    child: _buildPieChart(totalPositiveMentions, totalNegativeMentions),
                  ),
                  // --- 4. BAR CHART ---
                  Expanded(
                    flex: 3,
                    child: _buildBarChart(topCriticized),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ] else 
              const Center(
                child: Text(
                  "Not enough data to generate charts.",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            
            // --- Original Praised/Criticized Lists (Unchanged) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAspectColumn(
                      "👍 Top Praised", topPraised, Colors.greenAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAspectColumn(
                      "👎 Top Criticized", topCriticized, Colors.redAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // --- 🌟 NEW PIE CHART WIDGET 🌟 ---
  Widget _buildPieChart(double positive, double negative) {
    final double total = positive + negative;
    return Column(
      children: [
        const Text(
          "Sentiment Breakdown",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150, // Give the chart a defined height
          child: PieChart(
            PieChartData(
              sectionsSpace: 4, // Space between segments
              centerSpaceRadius: 40, // Donut hole
              sections: [
                // Positive "Liked" Segment
                PieChartSectionData(
                  value: positive,
                  title: '${(positive / total * 100).toStringAsFixed(0)}%',
                  color: Colors.greenAccent,
                  radius: 50,
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                // Negative "Disliked" Segment
                PieChartSectionData(
                  value: negative,
                  title: '${(negative / total * 100).toStringAsFixed(0)}%',
                  color: Colors.redAccent,
                  radius: 50,
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 🌟 NEW BAR CHART WIDGET 🌟 ---
  Widget _buildBarChart(List topCriticized) {
    // Find the highest value for the Y-axis limit
    final double maxY = topCriticized.isEmpty ? 10 : 
      (topCriticized.fold(0, (max, item) => (item[1] as int) > max ? (item[1] as int) : max)).toDouble() + 2;

    return Column(
      children: [
        const Text(
          "Top Disliked Features",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150, // Give the chart a defined height
          child: BarChart(
            BarChartData(
              maxY: maxY,
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              // Titles for the bottom (X-axis)
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final int index = value.toInt();
                      if (index < 0 || index >= topCriticized.length) return const Text('');
                      final String title = topCriticized[index][0]; // "battery"
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          title.substring(0, 3), // Show first 3 letters
                          style: const TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      );
                    },
                    reservedSize: 20,
                  ),
                ),
                // Titles for the left (Y-axis)
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value == 0 || value == maxY) return const Text(''); // Hide min/max
                      return Text(
                        '${value.toInt()}',
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                      );
                    },
                    reservedSize: 28,
                  ),
                ),
              ),
              // The actual bar data
              barGroups: [
                // We create a bar for each criticized item
                for (var i = 0; i < topCriticized.length; i++)
                  BarChartGroupData(
                    x: i, // The index of the bar
                    barRods: [
                      BarChartRodData(
                        toY: (topCriticized[i][1] as int).toDouble(), // The count
                        color: Colors.redAccent,
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  // --- Original Helper Widget (Unchanged) ---
  Widget _buildAspectColumn(String title, List aspects, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color),
        ),
        const SizedBox(height: 10),
        if (aspects.isEmpty)
          const Text("N/A", style: TextStyle(color: Colors.white54))
        else
          ...aspects.map((aspect) {
            final String name = aspect[0];
            final int count = aspect[1];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    "$name:",
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$count",
                    style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }
}