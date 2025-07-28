import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'E-Commerce App',
    theme: ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: true,
    home: HomePage(),
  ));
}

