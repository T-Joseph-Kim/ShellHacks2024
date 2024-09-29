// models/core/nutrient_detail.dart

class NutrientDetail {
  final String information;
  final String benefits;
  final String negatives;
  final String whatYouNeedToKnow;
  final String recommendations;
  final String userRecommendations;
  final List<String> sources;

  const NutrientDetail({
    required this.information,
    required this.benefits,
    required this.negatives,
    required this.whatYouNeedToKnow,
    required this.recommendations,
    required this.userRecommendations,
    required this.sources,
  });
}
