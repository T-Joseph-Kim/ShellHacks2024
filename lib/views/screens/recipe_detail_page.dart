import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/models/core/recipe.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/climate_footprint_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart'; // For Bar Chart
import 'package:hungry/views/widgets/ingredient_widget.dart';
import 'package:lottie/lottie.dart';
import '../widgets/nutrients_widget.dart'; // For Hand Animations

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  RecipeDetailPage({required this.recipeId});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  void changeAppBarColor(ScrollController scrollController) {
    if (scrollController.hasClients) {
      if (scrollController.offset > 2.0) {
        if (appBarColor != AppColor.primary) {
          setState(() {
            appBarColor = AppColor.primary;
          });
        }
      } else {
        if (appBarColor != Colors.transparent) {
          setState(() {
            appBarColor = Colors.transparent;
          });
        }
      }
    }
  }

  Future<Recipe?> getRecipeById(String recipeId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('scans')
          .doc(recipeId)
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        Recipe recipe = Recipe.fromJson(data);
        return recipe;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching recipe: $e');
      return null;
    }
  }

  // Assuming getNutrientDailyValues is a synchronous function
  List<NutrientData> getNutrientDailyValues(Recipe recipe) {
    // Implement your logic to extract nutrient data from the recipe
    // Example:
    return [
      NutrientData(name: 'Total Fat', value: 65, dailyValue: 78),
      NutrientData(name: 'Trans Fat', value: 10, dailyValue: 20),
      NutrientData(name: 'Sat. Fat', value: 20, dailyValue: 40),
      NutrientData(name: 'Sugar', value: 30, dailyValue: 50),
      NutrientData(name: 'Sodium', value: 1200, dailyValue: 2400),
      NutrientData(name: 'Cholesterol', value: 300, dailyValue: 300),
      NutrientData(name: 'Protein', value: 50, dailyValue: 50),
      // Add more nutrients as needed
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe?>(
      future: getRecipeById(widget.recipeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Error message
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Recipe not found
          return Scaffold(
            body: Center(child: Text('Recipe not found.')),
          );
        } else {
          Recipe recipe = snapshot.data!;
          return buildRecipeDetail(context, recipe);
        }
      },
    );
  }

  Widget buildRecipeDetail(BuildContext context, Recipe recipe) {
    // Get the list of nutrient data synchronously
    List<NutrientData> nutrientData = getNutrientDailyValues(recipe);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AnimatedContainer(
          color: appBarColor,
          duration: Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            elevation: 0,
            centerTitle: true,
            title: Text('Recipe Detail',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/bookmark.svg',
                      color: Colors.white)),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: GestureDetector(
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(recipe.photo ?? ''),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 300, // Specify a fixed height
                child: NutrientBarChart(data: nutrientData),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: 20, bottom: 30, left: 16, right: 16),
              color: AppColor.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Calories and Time
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/fire-filled.svg',
                        color: Colors.white,
                        width: 16,
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          recipe.calories ?? '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.alarm, size: 16, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          recipe.time ?? '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  // Recipe Title
                  Container(
                    margin: EdgeInsets.only(bottom: 12, top: 16),
                    child: Text(
                      recipe.title ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter'),
                    ),
                  ),
                  // Recipe Description
                  Text(
                    recipe.description ?? '',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withOpacity(0.6),
                labelStyle: TextStyle(
                    fontFamily: 'Inter', fontWeight: FontWeight.w500),
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Ingredients'),
                  Tab(text: 'Health'),
                  Tab(text: 'Footprint'),
                ],
              ),
            ),
            pinned: true,
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Ingredients Tab
            Padding(padding: const EdgeInsets.all(5.0),
            child:IngredientsWidget(ingredients: recipe.ingredients ?? [])),
            // Health Tab - Now without Bar Chart
            Padding(
            padding: const EdgeInsets.all(5.0), 
            child: NutrientsWidget(nutrients: recipe.nutrients),
            // Footprint Tab
              ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClimateFootprintTile(data: recipe.climateFootprint),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom SliverPersistentHeaderDelegate for TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.secondary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// NutrientBarChart Widget
class NutrientBarChart extends StatefulWidget {
  final List<NutrientData> data;

  NutrientBarChart({required this.data});

  @override
  _NutrientBarChartState createState() => _NutrientBarChartState();
}

class _NutrientBarChartState extends State<NutrientBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _showHand = true;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for hand animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation movement
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.5), // Start off-screen at the bottom
      end: Offset(0.0, 0.0), // Move to original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();

    // Optionally hide the hand after a delay
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showHand = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to assign colors to each bar
  Color getBarColor(String nutrientName) {
    switch (nutrientName) {
      case 'Total Fat':
        return Colors.orange;
      case 'Trans Fat':
        return Colors.red;
      case 'Sat. Fat':
        return Colors.deepOrange;
      case 'Sugar':
        return Colors.pink;
      case 'Sodium':
        return Colors.blue;
      case 'Cholesterol':
        return Colors.green;
      case 'Savings':
        return Colors.teal;
      case 'Protein':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure there is data to display
    if (widget.data.isEmpty) {
      return Center(child: Text('No nutrient data available.'));
    }

    return Stack(
      children: [
        // Bar Chart
        BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 120, // Adjust based on your data
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.grey,
                getTooltipItem:
                    (group, groupIndex, rod, rodIndex) {
                  String nutrient =
                      widget.data[group.x.toInt()].name;
                  double value =
                      widget.data[group.x.toInt()].value;
                  return BarTooltipItem(
                    '$nutrient\n${value.toStringAsFixed(1)}',
                    TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget:
                      (double value, TitleMeta meta) {
                    final labels =
                        widget.data.map((e) => e.name).toList();
                    final index = value.toInt();
                    if (index < 0 || index >= labels.length)
                      return Container();
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        labels[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: widget.data.asMap().entries.map((entry) {
              int index = entry.key;
              NutrientData nutrient = entry.value;

              // Calculate the percentage of the daily value
              double percentage =
                  (nutrient.value / nutrient.dailyValue) * 100;
              percentage =
                  percentage.clamp(0, 120); // Limit the value for display

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: percentage,
                    width: 16,
                    color: getBarColor(nutrient.name),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        // Hand Animation
        if (_showHand)
          SlideTransition(
            position: _animation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(
                'assets/animations/hand_animation.json', // Ensure you have this file
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
      ],
    );
  }
}

// Example NutrientData model
class NutrientData {
  final String name;
  final double value;
  final double dailyValue;

  NutrientData({
    required this.name,
    required this.value,
    required this.dailyValue,
  });
}
