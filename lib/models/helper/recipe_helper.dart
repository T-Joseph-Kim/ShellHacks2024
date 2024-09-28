import 'package:hungry/models/core/recipe.dart';

class RecipeHelper {
  static List<Recipe> featuredRecipe = featuredRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();

  static List<Recipe> recommendationRecipe = recommendationRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();

  static List<Recipe> newlyPostedRecipe = newlyPostedRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();

  static List<Recipe> sweetFoodRecommendationRecipe = sweetFoodRecommendationRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();

  static Recipe popularRecipe = Recipe.fromJson(popularRecipeRawData);

  static List<Recipe> searchResultRecipe = searchResultRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();

  static List<Recipe> bookmarkedRecipe = bookmarkedRecipeRawData
      .map((data) => Recipe.fromJson(data))
      .toList();
}

var bookmarkedRecipeRawData = [
  {
    'title': 'Berry Smoothie Bowl',
    'photo': 'assets/images/bookmark1.jpg',
    'calories': '400 Cal',
    'time': '10 min',
    'description': 'A refreshing berry smoothie bowl topped with fruits and nuts.',
    'servings_per_container': '1',
    'serving_size': '350g',
    'nutrients': {
      'Calories': ['400 Cal', '20%'],
      'Protein': ['10g', '20%'],
      'Fat': ['5g', '8%'],
      'Carbohydrates': ['80g', '27%'],
      'Fiber': ['12g', '48%'],
    },
    'climateFootprint': {
      'productName': 'Berry Smoothie Bowl',
      'totalClimateImpact': 1.5,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.0, 'shareOfTotal': 66.7},
        {'name': 'Processing', 'climateImpact': 0.3, 'shareOfTotal': 20.0},
        {'name': 'Transportation', 'climateImpact': 0.2, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Mixed Berries',
      'Banana',
      'Almond Milk',
      'Granola',
      'Chia Seeds',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Blend berries, banana, and almond milk until smooth.'},
      {'step': '2', 'description': 'Pour into a bowl.'},
      {'step': '3', 'description': 'Top with granola and chia seeds.'},
      {'step': '4', 'description': 'Enjoy immediately.'},
    ],
    'reviews': [
      {'username': '@smoothieQueen', 'review': 'Perfect breakfast!'},
      {'username': '@healthKick', 'review': 'Delicious and nutritious.'},
    ],
  },
  // Add more recipes as needed...
];
var searchResultRecipeRawData = [
  {
    'title': 'Classic Beef Burger',
    'photo': 'assets/images/search1.jpg',
    'calories': '800 Cal',
    'time': '30 min',
    'description': 'A juicy beef burger with all the classic toppings.',
    'servings_per_container': '1',
    'serving_size': '250g',
    'nutrients': {
      'Calories': ['800 Cal', '40%'],
      'Protein': ['35g', '70%'],
      'Fat': ['50g', '77%'],
      'Carbohydrates': ['50g', '17%'],
      'Fiber': ['3g', '12%'],
    },
    'climateFootprint': {
      'productName': 'Beef Burger',
      'totalClimateImpact': 6.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 4.0, 'shareOfTotal': 66.7},
        {'name': 'Processing', 'climateImpact': 1.2, 'shareOfTotal': 20.0},
        {'name': 'Transportation', 'climateImpact': 0.8, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Ground Beef',
      'Burger Bun',
      'Lettuce',
      'Tomato',
      'Cheddar Cheese',
      'Onion',
      'Ketchup',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Form ground beef into a patty and season with salt and pepper.'},
      {'step': '2', 'description': 'Grill or pan-fry the patty to desired doneness.'},
      {'step': '3', 'description': 'Toast the burger bun lightly.'},
      {'step': '4', 'description': 'Assemble the burger with toppings and condiments.'},
      {'step': '5', 'description': 'Serve hot with fries or salad.'},
    ],
    'reviews': [
      {'username': '@burgerLover', 'review': 'Classic and delicious!'},
      {'username': '@foodFanatic', 'review': 'Easy to make and satisfying.'},
    ],
  },
  // Add more recipes as needed...
];
var sweetFoodRecommendationRecipeRawData = [
  {
    'title': 'Chocolate Lava Cake',
    'photo': 'assets/images/sweetfood3.jpg',
    'calories': '600 Cal',
    'time': '30 min',
    'description': 'An indulgent dessert with a rich, molten chocolate center.',
    'servings_per_container': '2',
    'serving_size': '150g',
    'nutrients': {
      'Calories': ['600 Cal', '30%'],
      'Protein': ['7g', '14%'],
      'Fat': ['40g', '62%'],
      'Carbohydrates': ['55g', '18%'],
      'Sugar': ['40g', '80%'],
    },
    'climateFootprint': {
      'productName': 'Chocolate Lava Cake',
      'totalClimateImpact': 3.5,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 2.0, 'shareOfTotal': 57.1},
        {'name': 'Processing', 'climateImpact': 1.0, 'shareOfTotal': 28.6},
        {'name': 'Transportation', 'climateImpact': 0.5, 'shareOfTotal': 14.3},
      ],
    },
    'ingredients': [
      'Dark Chocolate',
      'Butter',
      'Sugar',
      'Eggs',
      'Flour',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Preheat the oven to 200°C and grease ramekins.'},
      {'step': '2', 'description': 'Melt chocolate and butter together.'},
      {'step': '3', 'description': 'Whisk in sugar and eggs until smooth.'},
      {'step': '4', 'description': 'Fold in flour gently.'},
      {'step': '5', 'description': 'Pour batter into ramekins and bake for 12 minutes.'},
      {'step': '6', 'description': 'Let it cool for a minute, then serve warm.'},
    ],
    'reviews': [
      {'username': '@dessertFan', 'review': 'Heavenly! The molten center is perfect.'},
      {'username': '@sweetTooth', 'review': 'My favorite dessert ever!'},
    ],
  },
  // Add more recipes as needed...
];
var newlyPostedRecipeRawData = [
  {
    'title': 'Avocado Toast with Poached Eggs',
    'photo': 'assets/images/newly_posted1.jpg',
    'calories': '500 Cal',
    'time': '20 min',
    'description': 'A simple yet delicious avocado toast topped with perfectly poached eggs.',
    'servings_per_container': '1',
    'serving_size': '200g',
    'nutrients': {
      'Calories': ['500 Cal', '25%'],
      'Protein': ['15g', '30%'],
      'Fat': ['35g', '54%'],
      'Carbohydrates': ['30g', '10%'],
      'Fiber': ['7g', '28%'],
    },
    'climateFootprint': {
      'productName': 'Avocado Toast',
      'totalClimateImpact': 2.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.2, 'shareOfTotal': 60.0},
        {'name': 'Processing', 'climateImpact': 0.5, 'shareOfTotal': 25.0},
        {'name': 'Transportation', 'climateImpact': 0.3, 'shareOfTotal': 15.0},
      ],
    },
    'ingredients': [
      'Avocado',
      'Whole Grain Bread',
      'Eggs',
      'Salt',
      'Pepper',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Toast the bread slices until golden brown.'},
      {'step': '2', 'description': 'Mash the avocado and spread it over the toast.'},
      {'step': '3', 'description': 'Poach the eggs to your liking.'},
      {'step': '4', 'description': 'Place the poached eggs on top of the avocado toast.'},
      {'step': '5', 'description': 'Season with salt and pepper, then serve.'},
    ],
    'reviews': [
      {'username': '@breakfastLover', 'review': 'A perfect start to my day!'},
      {'username': '@foodie', 'review': 'Simple and tasty.'},
    ],
  }, {
    'title': 'Vegetable Noodle Bowl',
    'photo': 'assets/images/featured1.jpg',
    'calories': '870 Cal',
    'time': '32 min',
    'description': 'A hearty bowl of noodles loaded with fresh vegetables.',
    'servings_per_container': '2',
    'serving_size': '300g',
    'nutrients': {
      'Calories': ['870 Cal', '43%'],
      'Protein': ['15g', '30%'],
      'Fat': ['10g', '15%'],
      'Carbohydrates': ['90g', '30%'],
      'Fiber': ['5g', '20%'],
    },
    'climateFootprint': {
      'productName': 'Vegetable Noodle Bowl',
      'totalClimateImpact': 3.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.8, 'shareOfTotal': 60.0},
        {'name': 'Processing', 'climateImpact': 0.8, 'shareOfTotal': 26.7},
        {'name': 'Transportation', 'climateImpact': 0.4, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Noodles',
      'Broccoli',
      'Carrots',
      'Soy Sauce',
      'Garlic',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Boil the noodles according to package instructions.'},
      {'step': '2', 'description': 'Sauté vegetables in a pan until tender.'},
      {'step': '3', 'description': 'Mix noodles and vegetables together.'},
      {'step': '4', 'description': 'Add soy sauce and garlic, then stir well.'},
      {'step': '5', 'description': 'Serve hot and enjoy!'},
    ],
    'reviews': [
      {'username': '@foodie123', 'review': 'Absolutely delicious and easy to make!'},
      {'username': '@veggieLover', 'review': 'A perfect meal for vegetarians.'},
    ],
  }, {
    'title': 'Vegetable Noodle Bowl',
    'photo': 'assets/images/featured1.jpg',
    'calories': '870 Cal',
    'time': '32 min',
    'description': 'A hearty bowl of noodles loaded with fresh vegetables.',
    'servings_per_container': '2',
    'serving_size': '300g',
    'nutrients': {
      'Calories': ['870 Cal', '43%'],
      'Protein': ['15g', '30%'],
      'Fat': ['10g', '15%'],
      'Carbohydrates': ['90g', '30%'],
      'Fiber': ['5g', '20%'],
    },
    'climateFootprint': {
      'productName': 'Vegetable Noodle Bowl',
      'totalClimateImpact': 3.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.8, 'shareOfTotal': 60.0},
        {'name': 'Processing', 'climateImpact': 0.8, 'shareOfTotal': 26.7},
        {'name': 'Transportation', 'climateImpact': 0.4, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Noodles',
      'Broccoli',
      'Carrots',
      'Soy Sauce',
      'Garlic',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Boil the noodles according to package instructions.'},
      {'step': '2', 'description': 'Sauté vegetables in a pan until tender.'},
      {'step': '3', 'description': 'Mix noodles and vegetables together.'},
      {'step': '4', 'description': 'Add soy sauce and garlic, then stir well.'},
      {'step': '5', 'description': 'Serve hot and enjoy!'},
    ],
    'reviews': [
      {'username': '@foodie123', 'review': 'Absolutely delicious and easy to make!'},
      {'username': '@veggieLover', 'review': 'A perfect meal for vegetarians.'},
    ],
  },
  // Add more recipes as needed...
];
var popularRecipeRawData = {
  'title': 'Green Healthy Meat & Vegetable Pizza',
  'photo': 'assets/images/popularnowpizza.jpg',
  'calories': '1500 Cal',
  'time': '25 min',
  'description': 'A delicious pizza loaded with healthy vegetables and meat.',
  'servings_per_container': '4',
  'serving_size': '150g',
  'nutrients': {
    'Calories': ['375 Cal', '19%'],
    'Protein': ['20g', '40%'],
    'Fat': ['15g', '23%'],
    'Carbohydrates': ['45g', '15%'],
  },
  'climateFootprint': {
    'productName': 'Meat & Vegetable Pizza',
    'totalClimateImpact': 5.0,
    'activities': [
      {'name': 'Agriculture', 'climateImpact': 3.0, 'shareOfTotal': 60.0},
      {'name': 'Processing', 'climateImpact': 1.5, 'shareOfTotal': 30.0},
      {'name': 'Transportation', 'climateImpact': 0.5, 'shareOfTotal': 10.0},
    ],
  },
  'ingredients': [
    'Pizza Dough',
    'Tomato Sauce',
    'Mozzarella Cheese',
    'Bell Peppers',
    'Mushrooms',
    'Grilled Chicken',
  ],
  'tutorial': [
    {'step': '1', 'description': 'Spread tomato sauce over the pizza base.'},
    {'step': '2', 'description': 'Add cheese and toppings evenly.'},
    {'step': '3', 'description': 'Bake in a preheated oven at 200°C for 15 minutes.'},
    {'step': '4', 'description': 'Slice and serve hot.'},
  ],
  'reviews': [
    {'username': '@pizzaLover', 'review': 'Best homemade pizza ever!'},
    {'username': '@healthyEats', 'review': 'A great way to enjoy pizza without guilt.'},
  ],
};
var featuredRecipeRawData = [
  {
    'title': 'Vegetable Noodle Bowl',
    'photo': 'assets/images/featured1.jpg',
    'calories': '870 Cal',
    'time': '32 min',
    'description': 'A hearty bowl of noodles loaded with fresh vegetables.',
    'servings_per_container': '2',
    'serving_size': '300g',
    'nutrients': {
      'Calories': ['870 Cal', '43%'],
      'Protein': ['15g', '30%'],
      'Fat': ['10g', '15%'],
      'Carbohydrates': ['90g', '30%'],
      'Fiber': ['5g', '20%'],
    },
    'climateFootprint': {
      'productName': 'Vegetable Noodle Bowl',
      'totalClimateImpact': 3.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.8, 'shareOfTotal': 60.0},
        {'name': 'Processing', 'climateImpact': 0.8, 'shareOfTotal': 26.7},
        {'name': 'Transportation', 'climateImpact': 0.4, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Noodles',
      'Broccoli',
      'Carrots',
      'Soy Sauce',
      'Garlic',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Boil the noodles according to package instructions.'},
      {'step': '2', 'description': 'Sauté vegetables in a pan until tender.'},
      {'step': '3', 'description': 'Mix noodles and vegetables together.'},
      {'step': '4', 'description': 'Add soy sauce and garlic, then stir well.'},
      {'step': '5', 'description': 'Serve hot and enjoy!'},
    ],
    'reviews': [
      {'username': '@foodie123', 'review': 'Absolutely delicious and easy to make!'},
      {'username': '@veggieLover', 'review': 'A perfect meal for vegetarians.'},
    ],
  },
  // Add more recipes as needed...
];
var recommendationRecipeRawData = [
  {
    'title': 'Vegetable Noodle Bowl',
    'photo': 'assets/images/featured1.jpg',
    'calories': '870 Cal',
    'time': '32 min',
    'description': 'A hearty bowl of noodles loaded with fresh vegetables.',
    'servings_per_container': '2',
    'serving_size': '300g',
    'nutrients': {
      'Calories': ['870 Cal', '43%'],
      'Protein': ['15g', '30%'],
      'Fat': ['10g', '15%'],
      'Carbohydrates': ['90g', '30%'],
      'Fiber': ['5g', '20%'],
    },
    'climateFootprint': {
      'productName': 'Vegetable Noodle Bowl',
      'totalClimateImpact': 3.0,
      'activities': [
        {'name': 'Agriculture', 'climateImpact': 1.8, 'shareOfTotal': 60.0},
        {'name': 'Processing', 'climateImpact': 0.8, 'shareOfTotal': 26.7},
        {'name': 'Transportation', 'climateImpact': 0.4, 'shareOfTotal': 13.3},
      ],
    },
    'ingredients': [
      'Noodles',
      'Broccoli',
      'Carrots',
      'Soy Sauce',
      'Garlic',
    ],
    'tutorial': [
      {'step': '1', 'description': 'Boil the noodles according to package instructions.'},
      {'step': '2', 'description': 'Sauté vegetables in a pan until tender.'},
      {'step': '3', 'description': 'Mix noodles and vegetables together.'},
      {'step': '4', 'description': 'Add soy sauce and garlic, then stir well.'},
      {'step': '5', 'description': 'Serve hot and enjoy!'},
    ],
    'reviews': [
      {'username': '@foodie123', 'review': 'Absolutely delicious and easy to make!'},
      {'username': '@veggieLover', 'review': 'A perfect meal for vegetarians.'},
    ],
  },
  // Add more recipes as needed...
];
