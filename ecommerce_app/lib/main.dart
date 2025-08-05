import  'package:flutter/material.dart';
import 'injection_container.dart' as di;
void main() async {
  await di.init();
  
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('E-commerce App'),
        ),
        body: const Center(
          child:  Text('Welcome to the E-commerce App!'),
        ),
      ),
    );
  }
}
