// import 'package:e_commerce/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/data/dataRepo.dart';
// import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/widgets/product_tile.dart';
import 'package:go_router/go_router.dart';


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
                    GoRouter.of(context).go('/home/search'); // Navigate to the search page
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
            GoRouter.of(context).go('/home/update');
            // Navigate to the cart page
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}


