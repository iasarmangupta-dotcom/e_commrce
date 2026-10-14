import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String seller;
  final String description;
  final String imageUrl;
  final List<Color> colors;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.seller,
    required this.description,
    required this.imageUrl,
    required this.colors,
    this.isFavorite = false,
  });
}
