import 'package:flutter/material.dart';
import 'package:e_commerce/models/product.dart';

class CategoryAndRating extends StatelessWidget {
  const CategoryAndRating({super.key, required this.product , this.time = 1.0});

  final Product product;
  final double time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.formattedCategory,
          style: TextStyle(
            fontSize: 12* time,
            color: Color(0xFFAAAAAA),
          ),
        ),
        RichText(
          text: TextSpan(
            text: '★ ',
            style: TextStyle(
              fontSize: 20 * time,
              color: Color(0xFFFFD700),
            ),
            children: [
              TextSpan(
                text: product.formattedRating,
                style: TextStyle(
                  fontSize: 12 * time,
                  color: Color(0xFFAAAAAA),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}