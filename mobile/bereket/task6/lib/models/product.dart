
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String imageUrl;
  final String category;
  final double price;
  final double rating;
  final String description;

  Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
  });

  String get formattedPrice {
    return '\$${price.toStringAsFixed(2)}';
  }
  String get formattedRating {
    return '(${rating.toStringAsFixed(1)})';
  }
  String get formattedCategory {
    return category;
  }
  String get formattedName {
    return name;
  }
  String get formattedDescription {
    return description;
  }
  get image {
    return AssetImage(imageUrl);
  }
}