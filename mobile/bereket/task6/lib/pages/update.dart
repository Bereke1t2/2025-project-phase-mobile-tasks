// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:e_commerce/models/product.dart';
// import 'package:e_commerce/data/dataRepo.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Product', style: TextStyle(fontSize: 16)),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF3F51F3)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
        children: [
          InputImage(),
          const SizedBox(height: 20),
          Input(lebel: "Name"),
          const SizedBox(height: 20),
          Input(lebel: "Category"),
          const SizedBox(height: 20),
          Input(lebel: "Price" , placeholder: "\$"),
          const SizedBox(height: 20),
          Input(lebel: "Description", height: 60 ),
          const SizedBox(height: 20),
          Button(onPressed: (){}, name: "ADD", color: const Color(0xFF3F51F3)),
          const SizedBox(height: 20),
          Button(onPressed: (){}, name: "DELETE", borderColor: const Color.fromRGBO(255, 19, 19, 0.79) , textColor: const Color.fromRGBO(255, 19, 19, 0.79),),
        ],
          ),
        ),
      ),
    );
  }
}

class InputImage extends StatelessWidget {

  const InputImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Handle image selection
            print('Image tapped');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color:  Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF3F3F3),
            ),
            height: 190,
            width: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Icon(Icons.image, color: Color(0xFF3E3E3E), size: 48),
                const SizedBox(height: 10),
                Text(
                  'upload image',
                  style: TextStyle(color: Color(0xFF3E3E3E), fontSize: 14),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}

class Input extends StatelessWidget {
  final String lebel;
  final int height;
  final String placeholder;
  const Input({super.key , required this.lebel , this.height = 15, this.placeholder = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lebel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E3E3E),
          ),
        ),
        TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF3F3F3),
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFFB0B0B0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height.toDouble()),
          ),
          style: const TextStyle(fontSize: 16),
          textAlignVertical: TextAlignVertical.center,
          textDirection: TextDirection.rtl, 
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Function onPressed;
  const Button({
    super.key,
    this.name = 'Add Product',
    this.height = 50,
    this.width = double.infinity,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor , width: 1),
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}