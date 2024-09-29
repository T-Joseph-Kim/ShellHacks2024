import 'package:hungry/models/core/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NutrientData Model
class NutrientData {
  final String name;
  final double value;       // Actual value from the recipe
  final double dailyValue;  // Recommended daily value

  NutrientData({
    required this.name,
    required this.value,
    required this.dailyValue,
  });
   @override
  String toString() {
    return 'NutrientData{name: $name, value: $value, dailyValue: $dailyValue}';
  }
}

double getNutrientValueFromRecipe(Map<String, List<String>>? nutrients, String key) {
  if (nutrients != null && nutrients.containsKey(key) && nutrients[key] != null && nutrients[key]!.isNotEmpty) {
    return double.tryParse(nutrients[key]![0]) ?? 0.0; // Assuming the first value represents the nutrient amount
  }
  return 0.0;
}

// Function to get the user's age and gender from local storage and set daily values accordingly
// Updated Function to Get Nutrient Daily Values, including Protein
List<NutrientData> getNutrientDailyValues(Recipe recipe) {
  int age = 25; // Placeholder for age
  String gender = "Male"; // Placeholder for gender
  print('User Age: $age');
  print('User Gender: $gender');

  // Define daily values based on age and gender
  double totalFatDailyValue = 0;
  double saturatedFatDailyValue = 0.1; // 10% kcal is the general recommendation for all
  double transFatDailyValue = 0.0; // Assume minimal intake
  double sodiumDailyValue = 0;
  double proteinDailyValue = 0;

  // Switch cases to determine daily values for each age and gender group
  if (gender.toLowerCase() == 'male') {
    switch (age) {
      case 1:
      case 2:
      case 3:
        totalFatDailyValue = 40; // 30-40% for age 1-3
        sodiumDailyValue = 1500;
        proteinDailyValue = 13;
        break;
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
        totalFatDailyValue = 35; // 25-35% for age 4-8
        sodiumDailyValue = 1900;
        proteinDailyValue = 19;
        break;
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
        totalFatDailyValue = 35; // 25-35% for age 9-13
        sodiumDailyValue = 2200;
        proteinDailyValue = 34;
        break;
      case 14:
      case 15:
      case 16:
      case 17:
      case 18:
        totalFatDailyValue = 35; // 25-35% for age 14-18
        sodiumDailyValue = 2300;
        proteinDailyValue = 52;
        break;
      default:
        totalFatDailyValue = 35; // 20-35% for age 19+
        sodiumDailyValue = 2300;
        proteinDailyValue = 56;
    }
  } else if (gender.toLowerCase() == 'female') {
    switch (age) {
      case 1:
      case 2:
      case 3:
        totalFatDailyValue = 40; // 30-40% for age 1-3
        sodiumDailyValue = 1500;
        proteinDailyValue = 13;
        break;
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
        totalFatDailyValue = 35; // 25-35% for age 4-8
        sodiumDailyValue = 1900;
        proteinDailyValue = 19;
        break;
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
        totalFatDailyValue = 35; // 25-35% for age 9-13
        sodiumDailyValue = 2200;
        proteinDailyValue = 34;
        break;
      case 14:
      case 15:
      case 16:
      case 17:
      case 18:
        totalFatDailyValue = 35; // 25-35% for age 14-18
        sodiumDailyValue = 2300;
        proteinDailyValue = 46;
        break;
      default:
        totalFatDailyValue = 35; // 20-35% for age 19+
        sodiumDailyValue = 2300;
        proteinDailyValue = 46;
    }
  }

  // Extract nutrient values from the recipe
  double totalFatValue = getNutrientValueFromRecipe(recipe.nutrients, "Total Fat");
  double transFatValue = getNutrientValueFromRecipe(recipe.nutrients, "Trans Fat");
  double saturatedFatValue = getNutrientValueFromRecipe(recipe.nutrients, "Saturated Fat");
  double sugarValue = getNutrientValueFromRecipe(recipe.nutrients, "Added Sugars");
  double sodiumValue = getNutrientValueFromRecipe(recipe.nutrients, "Sodium");
  double cholesterolValue = getNutrientValueFromRecipe(recipe.nutrients, "Cholesterol");
  double proteinValue = getNutrientValueFromRecipe(recipe.nutrients, "Protein");
  

  print(NutrientData(name: 'Total Fat', value: totalFatValue, dailyValue: totalFatDailyValue));
  print(NutrientData(name: 'Trans Fat', value: transFatValue, dailyValue: transFatDailyValue));
  print(NutrientData(name: 'Saturated Fat', value: saturatedFatValue, dailyValue: saturatedFatDailyValue));
  print(NutrientData(name: 'Sugar', value: sugarValue, dailyValue: 50));
  print(NutrientData(name: 'Sodium', value: sodiumValue, dailyValue: sodiumDailyValue));
  print(NutrientData(name: 'Cholesterol', value: cholesterolValue, dailyValue: 300));
  print(NutrientData(name: 'Protein', value: proteinValue, dailyValue: proteinDailyValue));
  // Create the nutrient data list
  return [
    NutrientData(name: 'Total Fat', value: totalFatValue, dailyValue: totalFatDailyValue),
    NutrientData(name: 'Trans Fat', value: transFatValue, dailyValue: transFatDailyValue),
    NutrientData(name: 'Saturated Fat', value: saturatedFatValue, dailyValue: saturatedFatDailyValue),
    NutrientData(name: 'Sugar', value: sugarValue, dailyValue: 50), // Assuming 50g as the default daily value for sugar
    NutrientData(name: 'Sodium', value: sodiumValue, dailyValue: sodiumDailyValue),
    NutrientData(name: 'Cholesterol', value: cholesterolValue, dailyValue: 300), // Assuming 300mg as the daily value for cholesterol
    NutrientData(name: 'Protein', value: proteinValue, dailyValue: proteinDailyValue),
  ];
}
