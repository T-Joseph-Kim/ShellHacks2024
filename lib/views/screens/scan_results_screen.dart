import 'package:flutter/material.dart';
import 'package:hungry/models/core/nutrient.dart';
import 'package:fl_chart/fl_chart.dart';

class ScanResultScreen extends StatefulWidget {
  @override
  _ScanResultScreenState createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _showHand = true;
Color getBarColor(String nutrientName) {
  switch (nutrientName) {
    case 'Total Fat':
      return Colors.orange;
    case 'Trans Fat':
      return Colors.red;
    case 'Sat. Fat':
      return Colors.deepOrange;
    case 'Sugar':
      return Colors.pink;
    case 'Sodium':
      return Colors.blue;
    case 'Cholesterol':
      return Colors.green;
    case 'Savings':
      return Colors.teal;
    default:
      return Colors.grey;
  }
}
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.5),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // Hide the hand after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showHand = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

Widget buildBarChart(List<NutrientData> data) {
  return BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 120, // Set according to the maximum percentage you expect
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              final labels = data.map((e) => e.name).toList();
              final index = value.toInt();
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 4,
                child: Text(
                  labels[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: data.asMap().entries.map((entry) {
        int index = entry.key;
        NutrientData nutrient = entry.value;

        // Calculate the percentage of the daily value
        double percentage = (nutrient.value / nutrient.dailyValue) * 100;
        percentage = percentage.clamp(0, 120); // Limit the value for display purposes

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: percentage,
              width: 16,
              color: getBarColor(nutrient.name),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      }).toList(),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    // Prepare your nutrient data
    List<NutrientData> nutrientData = [
      // Populate with actual data
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Results'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Bar Chart Section
                Container(
                  height: 300,
                  child: Stack(
                    children: [
                      buildBarChart(nutrientData),
                      // Hand Animation
                      if (_showHand)
                        SlideTransition(
                          position: _animation,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/hand_pointer.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Other content
              ],
            ),
          ),
          // Skip Button
          if (_showHand)
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _controller.stop();
                  setState(() {
                    _showHand = false;
                  });
                },
                child: Text('Skip'),
              ),
            ),
        ],
      ),
    );
  }
}
