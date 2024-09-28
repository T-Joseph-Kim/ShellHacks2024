class Recipe {
  String? title;
  String? photo;
  String? time;
  String? description;

  List<String>? ingredients; // Changed to List<String>
  List<TutorialStep>? tutorial;
  ClimateFootprint? climateFootprint;

  String? servingsPerContainer;
  String? servingSize;
  String? calories;
  Map<String, List<String>>? nutrients;

  Recipe({
    this.title,
    this.photo,
    this.time,
    this.description,
    this.ingredients,
    this.tutorial,
    this.climateFootprint,
    this.servingsPerContainer,
    this.servingSize,
    this.calories,
    this.nutrients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] as String?,
      photo: json['photo'] as String?,
      time: json['time'] as String?,
      description: json['description'] as String?,
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'] as List<dynamic>)
          : null,
      tutorial: json['tutorial'] != null
          ? TutorialStep.toList(List<Map<String, Object>>.from(json['tutorial'] as List))
          : null,
      climateFootprint: json['climateFootprint'] != null
          ? ClimateFootprint.fromJson(json['climateFootprint'] as Map<String, dynamic>)
          : null,
      servingsPerContainer: json['servings_per_container'] as String?,
      servingSize: json['serving_size'] as String?,
      calories: json['calories'] as String?,
      nutrients: json['nutrients'] != null
          ? (json['nutrients'] as Map<String, dynamic>).map((key, value) {
              return MapEntry(key, List<String>.from(value as List<dynamic>));
            })
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photo': photo,
      'time': time,
      'description': description,
      'ingredients': ingredients,
      'tutorial': tutorial?.map((step) => step.toMap()).toList(),
      'climateFootprint': climateFootprint?.toMap(),
      'servings_per_container': servingsPerContainer,
      'serving_size': servingSize,
      'calories': calories,
      'nutrients': nutrients,
    };
  }
}


class TutorialStep {
  String? step;
  String? description;
  TutorialStep({this.step, this.description});

  Map<String, Object?> toMap() {
    return {
      'step': step,
      'description': description,
    };
  }

  factory TutorialStep.fromJson(Map<String, Object> json) => TutorialStep(
        step: json['step'] as String?,
        description: json['description'] as String?,
      );

  static List<TutorialStep> toList(List<Map<String, Object>> json) {
    return List.from(json).map((e) => TutorialStep(step: e['step'], description: e['description'])).toList();
  }
}


class ClimateFootprint {
  String? productName;
  double? totalClimateImpact;
  List<FundamentalActivity>? activities;

  ClimateFootprint({this.productName, this.totalClimateImpact, this.activities});

  factory ClimateFootprint.fromJson(Map<String, dynamic> json) {
    return ClimateFootprint(
      productName: json['productName'] as String?,
      totalClimateImpact: (json['totalClimateImpact'] as num?)?.toDouble(),
      activities: json['activities'] != null
          ? FundamentalActivity.toList(List<Map<String, dynamic>>.from(json['activities'] as List))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'totalClimateImpact': totalClimateImpact,
      'activities': activities?.map((activity) => activity.toMap()).toList(),
    };
  }
}

class FundamentalActivity {
  String? name;
  double? climateImpact;
  double? shareOfTotal;

  FundamentalActivity({this.name, this.climateImpact, this.shareOfTotal});

  factory FundamentalActivity.fromJson(Map<String, dynamic> json) {
    return FundamentalActivity(
      name: json['name'] as String?,
      climateImpact: (json['climateImpact'] as num?)?.toDouble(),
      shareOfTotal: (json['shareOfTotal'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'climateImpact': climateImpact,
      'shareOfTotal': shareOfTotal,
    };
  }

  static List<FundamentalActivity> toList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((e) => FundamentalActivity.fromJson(e)).toList();
  }
}
