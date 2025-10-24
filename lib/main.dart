import 'package:flutter/material.dart';
import 'Splash_scrren.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Моя програма',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // Стартуємо з SplashScreen
      debugShowCheckedModeBanner: false,
    );
  }
}