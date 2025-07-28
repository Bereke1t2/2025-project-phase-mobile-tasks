import 'package:flutter/material.dart';
// import 'package:e_commerce/data/dataRepo.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/pages/home.dart';
import 'update.dart';

class Details extends StatelessWidget {
  final Product product;
  const Details({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 0),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15, top: 14),
        child: FloatingActionButton(
          highlightElevation: 40,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 30,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        
        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
              child: image(product.imageUrl),
          
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CategoryAndRating(product: product , time: 4/3,),
                  const SizedBox(height: 20),
                  NameAndPrice(product: product , time: 6/5,),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Size:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3E3E3E),
                        fontWeight: FontWeight.bold, // Makes the text bold
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Sizes(),
                  const SizedBox(height: 20),
                  Text(
                    "${product.formattedDescription.substring(0, 340)}...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3E3E3E),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(onPressed: (){}, name: "DELETE", borderColor: const Color.fromRGBO(255, 19, 19, 0.79) ,textColor: const Color.fromRGBO(255, 19, 19, 0.79) , width: 130,),
                    Button(onPressed: (){}, name: "UPDATE", color: const Color(0xFF3F51F3) , width: 130,),
                  ],
                ),

                ],
              ),
            ),

            // Add your widgets here
          ],
        ),
      ),
    );
  }
}


class Sizes extends StatefulWidget {
  const Sizes({super.key});

  @override
  State<Sizes> createState() => _SizesState();
}

class _SizesState extends State<Sizes> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enables horizontal scrolling
      child: Row(
        children: List.generate(10, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(right: 15 , top: 5 , bottom: 5),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Color.fromRGBO(63, 81, 243, 1)  : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  color: selectedIndex == index ? Color.fromRGBO(63, 81, 243, 1) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 39}',
                  style: TextStyle(
                    fontSize: 20,
                    color: selectedIndex == index ? Colors.white : Color(0xFF3E3E3E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

image(String imageUrl) {
  if (imageUrl.startsWith('http')) {
    return Image.network(
      imageUrl,
      height: 286,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      imageUrl,
      height: 286,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}