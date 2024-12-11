import 'detail_model.dart';

class RecipeModel {
  final int id;
  final String title;
  final String photoUrl;
  int likesCount;
  final int commentsCount;
  final String description;
  final String ingredients;
  final String cookingMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;
  bool isLiked;

  RecipeModel({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.description,
    required this.ingredients,
    required this.cookingMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.isLiked = false, // Default tidak di-like
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled Recipe',
      photoUrl: json['photo_url'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      description: json['description'] ?? 'No description available',
      ingredients: json['ingredients'] ?? 'No ingredients listed',
      cookingMethod: json['cooking_method'] ?? 'No method provided',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
      isLiked: json['is_liked'] ?? false, // Mengambil data dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'photo_url': photoUrl,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'description': description,
      'ingredients': ingredients,
      'cooking_method': cookingMethod,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'is_liked': isLiked, // Tambahkan ke JSON
    };
  }
}
