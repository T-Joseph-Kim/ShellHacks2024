// widgets/ingredients_widget.dart

import 'package:flutter/material.dart';
import 'dart:async';

class IngredientsWidget extends StatefulWidget {
  final List<String> ingredients;

  IngredientsWidget({required this.ingredients});

  @override
  _IngredientsWidgetState createState() => _IngredientsWidgetState();
}

class _IngredientsWidgetState extends State<IngredientsWidget> {
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredIngredients = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _filteredIngredients = widget.ingredients;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _filterIngredients();
    });
  }

  void _filterIngredients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isNotEmpty) {
        _filteredIngredients = widget.ingredients
            .where((ingredient) =>
                ingredient.toLowerCase().contains(query))
            .toList();
      } else {
        _filteredIngredients = widget.ingredients;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Ingredients',
              prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: 'e.g., Sugar',
            ),
          ),
        ),
        // List of Ingredients
        Expanded(
          child: _filteredIngredients.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _filteredIngredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.check, color: Colors.green),
                        title: Text(
                          _filteredIngredients[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'No ingredients found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
