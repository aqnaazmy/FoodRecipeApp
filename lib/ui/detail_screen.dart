import 'package:flutter/material.dart';
import 'package:flutter_pertemuan7/models/recipe_model.dart';
import 'package:flutter_pertemuan7/services/detail_services.dart';

import 'edit_recipe_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int recipeId;
  final bool initialIsLiked;
  final int initialLikesCount;

  RecipeDetailScreen({
    required this.recipeId,
    required this.initialIsLiked,
    required this.initialLikesCount,
  });

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<RecipeModel> recipeDetail;
  final RecipeService _recipeService = RecipeService();

  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
    _likesCount = widget.initialLikesCount;
    recipeDetail = _recipeService.getRecipeById(widget.recipeId);
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likesCount += 1;
      } else {
        _likesCount -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEFF3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F5F7),
        title: const Text('Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {
              'isLiked': _isLiked,
              'likesCount': _likesCount,
            });
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<RecipeModel>(
            future: recipeDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Tidak ada data'));
              } else {
                final recipe = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(recipe.photoUrl),
                        const SizedBox(height: 16),
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _toggleLike,
                              child: Icon(
                                _isLiked ? Icons.star : Icons.star_border,
                                color: _isLiked ? Colors.yellow : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text("$_likesCount likes"),
                            const SizedBox(width: 16),
                            const Icon(Icons.comment),
                            const SizedBox(width: 4),
                            Text("${recipe.commentsCount} comments"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(recipe.description),
                        const SizedBox(height: 16),
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(recipe.ingredients),
                        const SizedBox(height: 16),
                        const Text(
                          'Steps',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(recipe.cookingMethod),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color(0xFFEBEFF3),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: InkWell(
                  onTap: () {
                    // navigasi ke edit screen
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFEBEFF3),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12.0,
                          offset: Offset(-8, -8),
                          color: Colors.white,
                        ),
                        BoxShadow(
                          blurRadius: 12.0,
                          offset: Offset(8, 8),
                          color: Color(0xFFD4D4D4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Edit Recipe',
                        style: TextStyle(
                          color: Color(0xFF09060D),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
