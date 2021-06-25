import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodblog_app/homePage.dart';
import 'homePage.dart';

void main() {
  runApp(FoodBlogApp());
}

class FoodBlogApp extends StatelessWidget {
  @override
   Widget build(BuildContext context)
{
  return new MaterialApp(
  title: " Food Blog App",
  theme: new ThemeData
  (
    primarySwatch: Colors.amber,
  ),
     home: HomePage(),
  );
}
}
