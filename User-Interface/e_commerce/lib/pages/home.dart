import 'package:e_commerce/pages/details.dart';
import 'package:e_commerce/pages/update.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/data/dataRepo.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/pages/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/image/profile.jpeg',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('july 14 2025', style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA))),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Color(0xFF000000), fontFamily: 'Poppins'),
                children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                  ),
                  TextSpan(
                    text: 'Bereket',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color(0xFF3F51F3),
            ),
            onPressed: () {
              print('Notifications button pressed');
              // Navigate to the notifications page
            },
          ),
        ],
      ),
      body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available Products",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xFF3E3E3E),
                  fontFamily: 'Poppins',

                ),
              ),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                  // Navigate to the see all page
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF2F2F2)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFFD9D9D9),
                    size: 16,
                  ),
                ),
              )
            ],

          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: ProductList.length,
              itemBuilder: (context, index) {
                return ProductTile(product: ProductList[index]);
              },
            ),
          ),
        ],
      )
      
    ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF3F51F3),
          borderRadius: BorderRadius.circular(28),
        ),
        child: IconButton(
          onPressed: () {
            print('Cart button pressed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpdatePage()),
            );
            // Navigate to the cart page
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

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