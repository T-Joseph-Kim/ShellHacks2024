import 'package:flutter/material.dart';

class NutrientsWidget extends StatelessWidget {
  final Map<String, List<String>>? nutrients;

  NutrientsWidget({this.nutrients});

  @override
  Widget build(BuildContext context) {
    if (nutrients == null || nutrients!.isEmpty) {
      return Center(child: Text('No nutritional information available.'));
    }

    return ListView(
      padding: EdgeInsets.all(16),
      children: nutrients!.entries.map((entry) {
        String nutrientName = entry.key;
        List<String> values = entry.value;
        String amount = values.isNotEmpty ? values[0] : '';
        String dailyValue = values.length > 1 ? values[1] : '';

        return ListTile(
          title: Text(
            nutrientName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Amount: $amount\nDaily Value: $dailyValue'),
        );
      }).toList(),
    );
  }
}
