import 'package:flutter/material.dart';
import 'package:flutter_pertemuan7/models/recipe_model.dart';
import 'package:flutter_pertemuan7/services/recipe_services.dart';
import 'package:flutter_pertemuan7/ui/edit_recipe_screen.dart';
import 'package:flutter_pertemuan7/ui/add_recipe_screen.dart';

import 'detail_screen.dart'; // Tambahkan ini untuk screen tambah resep

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<RecipeModel>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = _recipeService.getAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Fungsi logout
            },
          ),
        ],
      ),
      body: FutureBuilder<List<RecipeModel>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureRecipes = _recipeService.getAllRecipes();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes available'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                          recipeId: recipe.id,
                          initialIsLiked: false,
                          initialLikesCount: recipe.likesCount,
                        ),
                      ),
                    );

                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: recipe.photoUrl.isNotEmpty
                              ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8.0)),
                            child: Image.network(
                              recipe.photoUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image,
                              size: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            recipe.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 11.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    recipe.isLiked = !recipe.isLiked; // Toggle status like
                                    if (recipe.isLiked) {
                                      recipe.likesCount += 1;
                                    } else {
                                      recipe.likesCount -= 1;
                                    }
                                  });
                                },
                                child: Icon(
                                  recipe.isLiked ? Icons.favorite : Icons.favorite_border,
                                  size: 15,
                                  color: recipe.isLiked ? Colors.red : Colors.grey,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${recipe.likesCount} ',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: (){

                                },
                                child: const Icon(
                                    Icons.comment_outlined, size: 15, color: Colors.grey
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${recipe.commentsCount} ',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                );

              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
          ).then((value) {
            if (value == true) {
              setState(() {
                futureRecipes = _recipeService.getAllRecipes();
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
