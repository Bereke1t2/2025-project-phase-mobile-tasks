import 'package:flutter/material.dart';
import 'package:e_commerce/models/product.dart';


class NameAndPrice extends StatelessWidget {
  const NameAndPrice({super.key, required this.product , this.time = 1.0});

  final Product product;
  final double time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.formattedName,
          style: TextStyle(
            fontSize: 18 * time,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          product.formattedPrice,
          style: TextStyle(
            fontSize: 16 * time,
            color: Color(0xFF3E3E3E),
          ),
        ),
      ],
    );
  }
}
