import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungry/models/core/recipe.dart';

class RecipeHelper {
  static List<Recipe> featuredRecipe = [];
  static List<Recipe> recommendationRecipe = [];
  static List<Recipe> newlyPostedRecipe = [];
  static List<Recipe> sweetFoodRecommendationRecipe = [];
  static Recipe? popularRecipe;
  static List<Recipe> searchResultRecipe = [];
  static List<Recipe> bookmarkedRecipe = [];

  static Future<void> initializeRecipes() async {
    try {
      // Fetching featured recipes from Firestore
      QuerySnapshot featuredSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      featuredRecipe = featuredSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching recommendation recipes from Firestore
      QuerySnapshot recommendationSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      recommendationRecipe = recommendationSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching newly posted recipes from Firestore
      QuerySnapshot newlyPostedSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      newlyPostedRecipe = newlyPostedSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching sweet food recommendation recipes from Firestore
      QuerySnapshot sweetFoodSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      sweetFoodRecommendationRecipe = sweetFoodSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching popular recipe (assuming there's a specific document for this)
      QuerySnapshot popularSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      searchResultRecipe = popularSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching search result recipes (assuming there's a search filter)
      QuerySnapshot searchResultSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      searchResultRecipe = searchResultSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetching bookmarked recipes from Firestore
      QuerySnapshot bookmarkedSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .get();
      bookmarkedRecipe = bookmarkedSnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }
}
