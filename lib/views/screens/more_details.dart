import 'package:flutter/material.dart';
import 'package:hungry/views/utils/AppColor.dart';

class MoreDetailsPage extends StatefulWidget {
  final Map<String, dynamic> apiResponse;

  MoreDetailsPage({required this.apiResponse});

  @override
  _MoreDetailsPageState createState() => _MoreDetailsPageState();
}

class _MoreDetailsPageState extends State<MoreDetailsPage> {
  Map<String, dynamic>? structuredNutritionData;

  @override
  void initState() {
    super.initState();
    // Automatically call the API with nutrition data when the page loads
    _getStructuredNutritionFacts();
  }

  Future<void> _getStructuredNutritionFacts() async {
    // API call logic here...
  }

  @override
  Widget build(BuildContext context) {
    // Extract the ingredient and product recognition data
    var ingredientData = widget.apiResponse['ingredient_data']['ingredients'];
    var productRecognition = widget.apiResponse['product_recognition'];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('More Details'),
          backgroundColor: AppColor.primary, // Use primary color from AppColor
          bottom: TabBar(
            tabs: [
              Tab(text: 'Nutrition'),
              Tab(text: 'Ingredients'),
              Tab(text: 'Product Recognition'),
            ],
            indicatorColor: AppColor.secondary, // Use secondary color for tab indicator
          ),
        ),
        body: TabBarView(
          children: [
            _buildNutritionSection(),
            _buildIngredientSection(ingredientData),
            _buildProductRecognitionSection(productRecognition),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionSection() {
    if (structuredNutritionData == null) {
      return Center(child: CircularProgressIndicator(color: AppColor.primary)); // Use AppColor for loading indicator
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recommendation: ${structuredNutritionData!["recommendation"]}',
              style: TextStyle(color: AppColor.primary2)), // Apply color to text
          Text('Servings per Container: ${structuredNutritionData!["servings_per_container"]}',
              style: TextStyle(color: AppColor.secondary)), // Apply secondary color to text
          Text('Serving Size: ${structuredNutritionData!["serving_size"]}'),
          Text('Calories: ${structuredNutritionData!["calories"]}'),
          SizedBox(height: 10),
          Text(
            'Nutrients:',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primarySoft), // Use color for the title
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: structuredNutritionData!["nutrients"].map<Widget>((nutrient) {
              return Text(
                '${nutrient["name"]}: ${nutrient["amount"]} (${nutrient["daily_value"]}%)',
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientSection(List<dynamic> ingredientData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredientData.map<Widget>((ingredient) {
          return Text('• $ingredient', style: TextStyle(color: AppColor.primary2)); // Use primary2 for ingredient list
        }).toList(),
      ),
    );
  }

  Widget _buildProductRecognitionSection(Map<String, dynamic> productRecognition) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Web Entities:', style: TextStyle(color: AppColor.primary)),
          ...productRecognition['web_entities'].map<Widget>((entity) {
            return Text('• ${entity["description"]} (Score: ${entity["score"]})',
                style: TextStyle(color: AppColor.primarySoft));
          }).toList(),
          SizedBox(height: 10),
          Text('Visually Similar Images:', style: TextStyle(color: AppColor.primary2)),
          ...productRecognition['visually_similar_images'].map<Widget>((imageUrl) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Image.network(imageUrl),
            );
          }).toList(),
        ],
      ),
    );
  }
}
