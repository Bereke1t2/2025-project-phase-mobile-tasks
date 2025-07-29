import 'package:flutter/material.dart';
import 'package:e_commerce/models/product.dart';
import 'category_and_rating.dart';
import 'name_and_price.dart';
import 'package:e_commerce/pages/details.dart';


class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(product: product)),
        );
        // Navigate to product details page
      },
      child:  Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.imageUrl.startsWith('assets/')) ...[
                Image.asset(
                  product.imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ] else ...[
                Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NameAndPrice(product: product),
                    CategoryAndRating(product: product),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
