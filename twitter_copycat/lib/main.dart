import 'package:flutter/material.dart';
import 'package:twitter_copycat/home.dart';

void main() {
  runApp(Twitter());
}

class Twitter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Copycat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        iconTheme: IconThemeData(color: new Color.fromRGBO(56, 161, 243, 1)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: new Color.fromRGBO(56, 161, 243, 1)),
      ),
      home: Home(),
    );
  }
}
