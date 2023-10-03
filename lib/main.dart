import 'package:flutter/material.dart';
import 'package:wallpapers/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallpaperApp',
      theme: ThemeData(
        //primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}


