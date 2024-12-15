import 'package:contactapp/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppHome());
}

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{},
      home:  Homescreen()
    );
  }
}
