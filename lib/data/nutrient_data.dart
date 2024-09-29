// data/nutrient_details.dart

import 'package:hungry/models/core/nutrient_detail.dart';

const Map<String, NutrientDetail> nutrientDetails = {
  'Sodium': NutrientDetail(
    information:
        'Sodium is an essential mineral that helps regulate fluid balance and blood pressure.',
    benefits:
        'Maintains proper nerve and muscle function.\nRegulates blood pressure.',
    negatives:
        'Excessive sodium intake can lead to high blood pressure, heart disease, and stroke.',
    whatYouNeedToKnow:
        'A high consumption of salt (or sodium) can cause raised blood pressure, which can increase the risk of heart disease and stroke. Many people who have high blood pressure do not know it, as there are often no symptoms. Most people consume too much salt (on average 9 to 12 grams per day), around twice the recommended maximum level of intake.',
    recommendations:
        'Limit the consumption of salt and salted food.\nReduce the quantity of salt used when cooking, and don’t salt again at the table.\nLimit the consumption of salty snacks and choose products with lower salt content.',
    userRecommendations:
        'Great job on keeping your sodium intake within recommended levels! Continue monitoring your salt consumption to maintain your healthy blood pressure.',
    sources: [
      'World Health Organization (WHO) - Fact sheet - Salt reduction',
      'National Health Service UK (NHS) - Salt: the facts',
    ],
  ),
  'Sugar': NutrientDetail(
    information:
        'Sugar is a simple carbohydrate that provides energy to the body.',
    benefits: 'Provides quick energy.\nEnhances flavor of foods.',
    negatives:
        'High intake can lead to obesity, diabetes, and dental cavities.',
    whatYouNeedToKnow:
        'Excessive consumption of sugar, especially added sugars, can contribute to various health issues, including weight gain, increased triglyceride levels, and elevated blood sugar levels, which can lead to insulin resistance.',
    recommendations:
        'Limit the intake of added sugars.\nChoose natural sources of sugar like fruits over processed sugary snacks.\nRead food labels to monitor sugar content.',
    userRecommendations:
        'Excellent work on reducing your sugar intake! Keep choosing healthier options to sustain your energy levels and overall health.',
    sources: [
      'World Health Organization (WHO) - Fact sheet - Sugar and health',
      'American Heart Association (AHA) - Added Sugars',
    ],
  ),
  'Trans Fat': NutrientDetail(
    information:
        'Trans fat is an unsaturated fat with at least one double bond in the trans configuration.',
    benefits:
        'Used in food processing to increase shelf life and improve texture.',
    negatives:
        'Raises LDL cholesterol and lowers HDL cholesterol, increasing the risk of heart disease and stroke.',
    whatYouNeedToKnow:
        'Trans fats are commonly found in processed foods, such as baked goods, snacks, and fried foods. They are harmful to heart health and should be minimized in the diet.',
    recommendations:
        'Avoid trans fats by checking food labels for partially hydrogenated oils.\nChoose natural fats like olive oil over processed fats.\nLimit consumption of fast food and commercially baked products.',
    userRecommendations:
        'You’re doing a fantastic job avoiding trans fats! Continue selecting whole foods and natural fats to support your heart health.',
    sources: [
      'World Health Organization (WHO) - Trans Fat',
      'American Heart Association (AHA) - Trans Fat',
    ],
  ),
  'Total Carbohydrates': NutrientDetail(
    information:
        'Total carbohydrates include sugars, starches, and fiber present in food.',
    benefits:
        'Primary source of energy for the body.\nSupports brain function and physical activity.',
    negatives:
        'Excessive carbohydrate intake, especially from refined sources, can lead to weight gain and increased blood sugar levels.',
    whatYouNeedToKnow:
        'Carbohydrates are broken down into glucose, which fuels the body’s cells. However, not all carbohydrates are created equal; complex carbs are healthier compared to simple, refined carbs.',
    recommendations:
        'Choose whole grains over refined grains.\nInclude a variety of fruits and vegetables in your diet.\nMonitor portion sizes to balance carbohydrate intake.',
    userRecommendations:
        'Great choice in selecting complex carbohydrates! Keep incorporating whole grains and diverse vegetables to maintain your energy and health.',
    sources: [
      'Dietary Guidelines for Americans - Carbohydrates',
      'Harvard T.H. Chan School of Public Health - Carbohydrates',
    ],
  ),
  'Dietary Fiber': NutrientDetail(
    information:
        'Dietary fiber consists of plant-based carbohydrates that cannot be digested by the human body.',
    benefits:
        'Promotes healthy digestion.\nHelps maintain bowel regularity.\nAids in achieving a healthy weight.',
    negatives:
        'Excessive fiber intake can cause digestive discomfort, such as bloating and gas.',
    whatYouNeedToKnow:
        'Fiber plays a crucial role in digestive health and can help lower cholesterol levels. It also aids in regulating blood sugar levels and promotes a feeling of fullness.',
    recommendations:
        'Include a variety of fiber-rich foods like fruits, vegetables, legumes, and whole grains in your diet.\nGradually increase fiber intake to allow your digestive system to adjust.\nStay hydrated to help fiber pass through the digestive tract smoothly.',
    userRecommendations:
        'Fantastic job incorporating dietary fiber into your meals! Continue enjoying a variety of fiber-rich foods to support your digestive health.',
    sources: [
      'World Health Organization (WHO) - Diet, nutrition and the prevention of chronic diseases',
      'American Dietetic Association - Dietary Fiber',
    ],
  ),
  'Iron': NutrientDetail(
    information:
        'Iron is a mineral essential for the production of hemoglobin, which carries oxygen in the blood.',
    benefits:
        'Prevents anemia.\nSupports immune function.\nEnhances cognitive performance.',
    negatives:
        'Excessive iron intake can cause organ damage and increase the risk of certain diseases.',
    whatYouNeedToKnow:
        'Iron is vital for transporting oxygen throughout the body. It exists in two forms: heme iron (found in animal products) and non-heme iron (found in plant-based foods).',
    recommendations:
        'Include both heme and non-heme iron sources in your diet.\nConsume vitamin C-rich foods alongside plant-based iron sources to enhance absorption.\nAvoid excessive intake of iron supplements unless prescribed.',
    userRecommendations:
        'Excellent work in maintaining adequate iron levels! Keep balancing your diet with diverse iron-rich foods to support your overall health.',
    sources: [
      'World Health Organization (WHO) - Iron deficiency anaemia',
      'National Institutes of Health (NIH) - Iron',
    ],
  ),
  'Total Sugars': NutrientDetail(
    information:
        'Total sugars include both naturally occurring sugars and added sugars in food.',
    benefits:
        'Provides quick energy.\nEnhances the taste of foods.',
    negatives:
        'High intake can lead to obesity, type 2 diabetes, and dental problems.',
    whatYouNeedToKnow:
        'Total sugars are found naturally in foods like fruits and dairy, as well as added to processed foods and beverages. Monitoring total sugar intake is essential for maintaining a balanced diet.',
    recommendations:
        'Limit the intake of sugary beverages and processed foods.\nOpt for natural sources of sugar, such as fruits, over added sugars.\nRead food labels to be aware of hidden sugars in products.',
    userRecommendations:
        'Great decision in moderating your total sugar intake! Continue choosing natural sugar sources to keep your energy levels stable and support your health.',
    sources: [
      'World Health Organization (WHO) - Sugar and health',
      'American Heart Association (AHA) - Added Sugars',
    ],
  ),
  'Added Sugars': NutrientDetail(
    information:
        'Added sugars are sugars that are added to foods during processing or preparation.',
    benefits:
        'Improves flavor and texture of foods.',
    negatives:
        'Contributes to empty calorie intake, increasing the risk of obesity, diabetes, and heart disease.',
    whatYouNeedToKnow:
        'Added sugars are often found in processed foods, sweets, and sugary beverages. They provide calories without essential nutrients, leading to weight gain and other health issues when consumed in excess.',
    recommendations:
        'Reduce consumption of processed and packaged foods high in added sugars.\nChoose beverages like water, herbal teas, or unsweetened drinks instead of sugary drinks.\nLimit sweets and desserts, opting for healthier alternatives like fruits.',
    userRecommendations:
        'Awesome effort in cutting down on added sugars! Keep selecting whole, unprocessed foods to maintain your healthy lifestyle.',
    sources: [
      'World Health Organization (WHO) - Sugar and health',
      'American Heart Association (AHA) - Added Sugars',
    ],
  ),
  'Cholesterol': NutrientDetail(
    information:
        'Cholesterol is a waxy substance found in all cells of the body, essential for producing hormones and vitamin D.',
    benefits:
        'Essential for hormone production.\nSupports cell membrane structure.',
    negatives:
        'High levels can increase the risk of heart disease and stroke.',
    whatYouNeedToKnow:
        'Cholesterol is produced by the liver and also obtained from animal-based foods. It plays a role in building cells and producing certain hormones.',
    recommendations:
        'Limit intake of high-cholesterol foods like fatty meats and full-fat dairy products.\nIncorporate heart-healthy fats, such as those found in fish, nuts, and olive oil.\nEngage in regular physical activity to help manage cholesterol levels.',
    userRecommendations:
        'Excellent management of cholesterol intake! Continue choosing heart-healthy foods and maintaining an active lifestyle to support your cardiovascular health.',
    sources: [
      'World Health Organization (WHO) - Cholesterol',
      'American Heart Association (AHA) - Cholesterol',
    ],
  ), 
  'Saturated Fat': NutrientDetail(
    information:
        'Saturated fat is a type of fat found in animal products and some plant oils.',
    benefits:
        'Provides essential fatty acids.\nSupports cell membrane integrity.',
    negatives:
        'Excessive consumption can raise LDL cholesterol, increasing the risk of heart disease.',
    whatYouNeedToKnow:
        'Saturated fats can elevate LDL (bad) cholesterol levels in the blood, which may lead to plaque buildup in arteries and result in heart disease and stroke.',
    recommendations:
        'Limit the intake of saturated fats by reducing consumption of fatty meats, full-fat dairy products, and processed foods. Opt for healthier fat sources like unsaturated fats found in fish, nuts, and vegetable oils.',
    userRecommendations:
        'Fantastic! You have managed to keep your saturated fat intake within healthy limits, supporting your cardiovascular health.',
    sources: [
      'American Heart Association (AHA) - Saturated Fat',
      'National Institutes of Health (NIH) - Saturated Fat',
    ],
  ),
  'Protein': NutrientDetail(
    information:
        'Protein is a macronutrient made up of amino acids, crucial for building and repairing tissues.',
    benefits:
        'Supports muscle growth and repair.\nEssential for enzyme and hormone production.\nHelps maintain a healthy immune system.',
    negatives:
        'Excessive protein intake can strain the kidneys and may lead to dehydration.',
    whatYouNeedToKnow:
        'Proteins are found in both animal and plant-based foods. They are vital for various bodily functions, including cell growth, immune responses, and tissue repair.',
    recommendations:
        'Include a variety of protein sources in your diet, such as lean meats, fish, legumes, and nuts.\nBalance protein intake with other macronutrients for overall health.\nAvoid excessive consumption of protein supplements unless necessary.',
    userRecommendations:
        'Great job incorporating sufficient protein into your diet! Continue balancing your protein sources to support your muscle and overall health.',
    sources: [
      'World Health Organization (WHO) - Protein',
      'National Institutes of Health (NIH) - Protein',
    ],
  ),
  // Add more nutrients as needed
};
