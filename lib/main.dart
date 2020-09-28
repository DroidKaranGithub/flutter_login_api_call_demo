import 'package:flutter/material.dart';
import 'widget/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
            headline6: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline1,
              ),
              Login(),
            ],
          ),
        ),
      ),
    );
  }
}
