import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/models/core/recipe.dart';
import 'package:hungry/views/screens/full_screen_image.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/climate_footprint_tile.dart';
import 'package:hungry/views/widgets/nutrients_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  RecipeDetailPage({required this.recipeId});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;

  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController!.addListener(() {
      changeAppBarColor(_scrollController!);
    });
  }

  void changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = AppColor.primary;
        });
      } else {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
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
      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: [
          // Recipe Image
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                      image: Image.network(recipe.photo ?? '',
                          fit: BoxFit.cover))));
            },
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(recipe.photo ?? ''),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                height: 280,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          // Recipe Info
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                EdgeInsets.only(top: 20, bottom: 30, left: 16, right: 16),
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
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.alarm, size: 16, color: Colors.white),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        recipe.time ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
          // TabBar
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: AppColor.secondary,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle:
                  TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500),
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'Ingredients'),
                Tab(text: 'Health'),
                Tab(text: 'Footprint'),
              ],
            ),
          ),
          // TabBarView
          Container(
            height: MediaQuery.of(context).size.height - 340, // Adjust height
            child: TabBarView(
              controller: _tabController,
              children: [
                // Ingredients Tab
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: recipe.ingredients?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recipe.ingredients![index]),
                    );
                  },
                ),
                // Health Tab
                NutrientsWidget(nutrients: recipe.nutrients),
                // Footprint Tab
                ClimateFootprintTile(data: recipe.climateFootprint),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
