import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter_copycat/screens/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Twitter());
}

class Twitter extends StatelessWidget {
  final Future<FirebaseApp> _initializer = Firebase.initializeApp();
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
      home: FutureBuilder(
          future: _initializer,
          builder: (context, snapshot) {
            if (snapshot.hasError) print('Error');
            if (snapshot.connectionState == ConnectionState.done)
              return InitialScreen(0);
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
