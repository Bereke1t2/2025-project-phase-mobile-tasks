// import 'package:e_commerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/routers/router.dart';

void main() {
  runApp(MaterialApp.router(
    title: 'E-Commerce App',
    theme: ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: true,
    routerConfig: router, //

  ),
  );
}

