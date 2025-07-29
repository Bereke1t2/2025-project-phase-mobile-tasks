
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String imageUrl;
  final String category;
  final double price;
  final double rating;
  final String description;
  final int id;

  Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    this.rating= 0.0,
    required this.description,
    this.id = 0,
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