import 'package:hungry/models/core/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NutrientData Model
class NutrientData {
  final String name;
  final double value; // Actual value from the recipe
  final double dailyValue; // Recommended daily value

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

// Function to get the user's age from local storage
Future<int?> getAge() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('age');
}

// Function to get the user's sex from local storage
Future<String?> getSex() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('sex');
}

// Function to get nutrient value from recipe
double getNutrientValueFromRecipe(
    Map<String, List<String>>? nutrients, String key) {
  if (nutrients != null &&
      nutrients.containsKey(key) &&
      nutrients[key] != null &&
      nutrients[key]!.isNotEmpty) {
    return double.tryParse(
            nutrients[key]![0].replaceAll(RegExp(r'[^\d.]'), '')) ??
        0.0; // Clean string before parsing
  }
  return 0.0;
}

// Function to get the user's age and gender from local storage and set daily values accordingly
// Updated Function to Get Nutrient Daily Values, including Protein
Future<List<NutrientData>> getNutrientDailyValues(Recipe recipe) async {
  // Retrieve age and sex asynchronously
  String? gender = await getSex();
  int? age = await getAge();
  print(age);
  print(gender);
  // Handle cases where age or gender might not be set
  if (gender == null || age == null) {
    // You can choose to throw an error, return empty list, or provide default values
    // For this example, we'll return an empty list
    print('Age or Gender not set in SharedPreferences.');
    return [];
  }

  // Define daily values based on age and gender
  double totalFatDailyValue = 0;
  double transFatDailyValue = 0; // New
  double saturatedFatDailyValue = 0; // New
  double cholesterolDailyValue = 0; // New
  double sodiumDailyValue = 0;
  double proteinDailyValue = 0;

  // Switch cases to determine daily values for each age and gender group
  if (gender.toLowerCase() == 'male') {
  if (age >= 1 && age <= 3) {
    totalFatDailyValue = 40; // 30-40% for age 1-3
    transFatDailyValue = 2; // Recommended limit
    saturatedFatDailyValue = 10; // 10% of calories
    cholesterolDailyValue = 300; // mg
    sodiumDailyValue = 1500;
    proteinDailyValue = 13;
  } else if (age >= 4 && age <= 8) {
    totalFatDailyValue = 35; // 25-35% for age 4-8
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 1900;
    proteinDailyValue = 19;
  } else if (age >= 9 && age <= 13) {
    totalFatDailyValue = 35; // 25-35% for age 9-13
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2200;
    proteinDailyValue = 34;
  } else if (age >= 14 && age <= 18) {
    totalFatDailyValue = 35; // 25-35% for age 14-18
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2300;
    proteinDailyValue = 52;
  } else {
    totalFatDailyValue = 35; // 20-35% for age 19+
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2300;
    proteinDailyValue = 56;
  }
} else if (gender.toLowerCase() == 'female') {
  if (age >= 1 && age <= 3) {
    totalFatDailyValue = 40; // 30-40% for age 1-3
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 1500;
    proteinDailyValue = 13;
  } else if (age >= 4 && age <= 8) {
    totalFatDailyValue = 35; // 25-35% for age 4-8
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 1900;
    proteinDailyValue = 19;
  } else if (age >= 9 && age <= 13) {
    totalFatDailyValue = 35; // 25-35% for age 9-13
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2200;
    proteinDailyValue = 34;
  } else if (age >= 14 && age <= 18) {
    totalFatDailyValue = 35; // 25-35% for age 14-18
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2300;
    proteinDailyValue = 46;
  } else {
    totalFatDailyValue = 35; // 20-35% for age 19+
    transFatDailyValue = 2;
    saturatedFatDailyValue = 10;
    cholesterolDailyValue = 300;
    sodiumDailyValue = 2300;
    proteinDailyValue = 46;
  }
} else {
  // Handle other genders or default values
  print('Unknown gender: $gender');
  // Assign default values or handle accordingly
  totalFatDailyValue = 35;
  transFatDailyValue = 2;
  saturatedFatDailyValue = 10;
  cholesterolDailyValue = 300;
  sodiumDailyValue = 2300;
  proteinDailyValue = 46;
}


  // Extract nutrient values from the recipe
  double totalFatValue =
      getNutrientValueFromRecipe(recipe.nutrients, "Total Fat");
  double transFatValue =
      getNutrientValueFromRecipe(recipe.nutrients, "Trans Fat");
  double saturatedFatValue =
      getNutrientValueFromRecipe(recipe.nutrients, "Saturated Fat");
  double sugarValue =
      getNutrientValueFromRecipe(recipe.nutrients, "Added Sugars");
  double sodiumValue = getNutrientValueFromRecipe(recipe.nutrients, "Sodium");
  double cholesterolValue =
      getNutrientValueFromRecipe(recipe.nutrients, "Cholesterol");
  double proteinValue = getNutrientValueFromRecipe(recipe.nutrients, "Protein");

  // Debug prints
  print(NutrientData(
      name: 'Total Fat', value: totalFatValue, dailyValue: totalFatDailyValue));
  print(NutrientData(
      name: 'Trans Fat', value: transFatValue, dailyValue: transFatDailyValue));
  print(NutrientData(
      name: 'Saturated Fat',
      value: saturatedFatValue,
      dailyValue: saturatedFatDailyValue));
  print(NutrientData(name: 'Sugar', value: sugarValue, dailyValue: 50));
  print(NutrientData(
      name: 'Sodium', value: sodiumValue, dailyValue: sodiumDailyValue));
  print(NutrientData(
      name: 'Cholesterol', value: cholesterolValue, dailyValue: 300));
  print(NutrientData(
      name: 'Protein', value: proteinValue, dailyValue: proteinDailyValue));

  // Create the nutrient data list
  return [
    NutrientData(
        name: 'Total Fat',
        value: totalFatValue,
        dailyValue: totalFatDailyValue),
    NutrientData(
        name: 'Trans Fat',
        value: transFatValue,
        dailyValue: transFatDailyValue),
    NutrientData(
        name: 'Saturated Fat',
        value: saturatedFatValue,
        dailyValue: saturatedFatDailyValue),
    NutrientData(
        name: 'Sugar',
        value: sugarValue,
        dailyValue: 50), // Assuming 50g as the default daily value for sugar
    NutrientData(
        name: 'Sodium', value: sodiumValue, dailyValue: sodiumDailyValue),
    NutrientData(
        name: 'Cholesterol',
        value: cholesterolValue,
        dailyValue: 300), // Assuming 300mg as the daily value for cholesterol
    NutrientData(
        name: 'Protein', value: proteinValue, dailyValue: proteinDailyValue),
  ];
}
