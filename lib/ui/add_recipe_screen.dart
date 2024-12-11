import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_pertemuan7/services/recipe_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final RecipeService _recipeService = RecipeService();

  String title = '';
  String description = '';
  String cookingMethod = '';
  String ingredients = '';
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final success = await _recipeService.createRecipe(
          title: title,
          description: description,
          cookingMethod: cookingMethod,
          ingredients: ingredients,
          photoPath: _selectedImage?.path ?? '',
        );

        if (success) {
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add recipe')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEFF3),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF3F5F7),
          title: const Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEFF3),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Color(0xFFD4D4D4),
                          offset: Offset(4, 4),
                          blurRadius: 8,
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 14.0
                      ),
                      ),
                      onSaved: (value) => title = value!,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a title' : null,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEFF3),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Color(0xFFD4D4D4),
                          offset: Offset(4, 4),
                          blurRadius: 8,
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                        hintText: 'Description',
                          contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 14.0
                      ),
                    ),
                      onSaved: (value) => description = value!,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a description' : null,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEFF3),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Color(0xFFD4D4D4),
                          offset: Offset(4, 4),
                          blurRadius: 8,
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(
                              border: InputBorder.none,
                            hintText: 'Cooking Method',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 14.0
                            ),
                          ),
                      onSaved: (value) => cookingMethod = value!,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter cooking method' : null,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEFF3),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Color(0xFFD4D4D4),
                          offset: Offset(4, 4),
                          blurRadius: 8,
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(
                              border: InputBorder.none,
                            hintText: 'Ingredients',
                              contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 14.0
                          ),
                    ),
                      onSaved: (value) => ingredients = value!,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter ingredients' : null,
                    ),
                  ),
                  const SizedBox(height: 26),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
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
                      child: Center(
                        child: _selectedImage == null
                            ? const Icon(
                          Icons.add_a_photo,
                          size: 30,
                          color: Colors.black,
                        )
                            : Image.file(
                          File(_selectedImage!.path),
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _submitRecipe,
                    child: Container(
                      width: double.infinity,
                      height: 55,
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
                          'Add Recipe',
                          style: TextStyle(
                            color: Color(0xFF09060D),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
