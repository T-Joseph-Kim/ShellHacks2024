// widgets/nutrients_widget.dart

import 'package:flutter/material.dart';
import 'package:hungry/models/core/nutrient_detail.dart';

import '../../data/nutrient_data.dart';

class NutrientsWidget extends StatelessWidget {
  final Map<String, List<String>>? nutrients;
  final bool userHasGoodStatus; // Indicates if user has a green check

  NutrientsWidget({this.nutrients, this.userHasGoodStatus = false});

  // Helper function to get color based on percentage
  Color getCardColor(double percentage) {
    if (percentage < 33.33) {
      return Color.fromARGB(255, 50, 202, 93);
    } else if (percentage < 66.66) {
      return Color.fromARGB(255, 250, 230, 55);
    } else {
      return Color.fromARGB(255, 212, 80, 68);
    }
  }

  // Function to parse percentage from string like '50%'
  double parsePercentage(String percentString) {
    String cleaned = percentString.replaceAll('%', '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  // Function to determine if an alert should be shown
  bool shouldShowAlert(double percentage) {
    return percentage > 66.66; // Threshold can be adjusted
  }

  // Helper function to map nutrient names to icons
  IconData getNutrientIcon(String nutrientName) {
    switch (nutrientName.toLowerCase()) {
      case 'sodium':
        return Icons.water_drop;
      case 'sugar':
        return Icons.cake;
      case 'saturated fat':
        return Icons.local_florist;
      case 'fat':
        return Icons.fitness_center;
      case 'trans fat':
        return Icons.remove_circle_outline;
      case 'total carbohydrates':
        return Icons.grain;
      case 'dietary fiber':
        return Icons.spa;
      case 'iron':
        return Icons.opacity;
      case 'total sugars':
        return Icons.local_drink;
      case 'added sugars':
        return Icons.icecream;
      case 'cholesterol':
        return Icons.bloodtype;
      case 'protein':
        return Icons.fitness_center;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (nutrients == null || nutrients!.isEmpty) {
      return Center(
        child: Text(
          'No nutritional information available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: nutrients!.length,
      itemBuilder: (context, index) {
        String nutrientName = nutrients!.keys.elementAt(index);
        List<String> values = nutrients![nutrientName]!;
        String amount = values.isNotEmpty ? values[0] : '';
        String dailyValueStr = values.length > 1 ? values[1] : '0%';
        double dailyValue = parsePercentage(dailyValueStr);

        // Ensure percentage is within 0-100%
        dailyValue = dailyValue.clamp(0.0, 100.0);

        // Determine card color
        Color cardColor = getCardColor(dailyValue);

        // Determine if alert should be shown
        bool showAlert = shouldShowAlert(dailyValue);

        return GestureDetector(
          onTap: () {
            // Show detailed information
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // To make it take 3/4 of the screen
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (context) {
                NutrientDetail? detail = nutrientDetails[nutrientName];
                return detail != null
                    ? FractionallySizedBox(
                        heightFactor: 0.75,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Handle Bar
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Nutrient Title with Icon
                                Row(
                                  children: [
                                    Icon(
                                      getNutrientIcon(nutrientName),
                                      color: Colors.blueGrey,
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        nutrientName,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                // Amount and Daily Value Chips
                                Row(
                                  children: [
                                    Chip(
                                      label: Text(
                                        'Amount: $amount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      label: Text(
                                        'Daily Value: $dailyValueStr',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                // What You Need to Know
                                Text(
                                  'What You Need to Know',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detail.whatYouNeedToKnow,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Recommendations
                                Text(
                                  'Recommendations',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  userHasGoodStatus
                                      ? detail.userRecommendations
                                      : detail.recommendations,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Benefits
                                Text(
                                  'Benefits',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detail.benefits,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Negatives
                                Text(
                                  'Negatives',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detail.negatives,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Sources
                                Text(
                                  'Sources',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: detail.sources
                                      .map(
                                        (source) => Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            '• $source',
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1.5,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        heightFactor: 0.75,
                        child: Center(
                          child: Text(
                            'No detailed information available for this nutrient.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      );
              },
            );
          },
          child: Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Nutrient Icon within a Circle
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      getNutrientIcon(nutrientName),
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Nutrient Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nutrient Name with Different Styling
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$nutrientName\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: 'Amount: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: '$amount\n',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: 'Daily Value: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: '$dailyValueStr',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Alert Icon with Different Formatting
                  showAlert
                      ? Tooltip(
                          message:
                              'High intake! Consider moderating your consumption.',
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                        )
                      : Tooltip(
                          message: 'Sufficient intake.',
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.greenAccent,
                            size: 24,
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
