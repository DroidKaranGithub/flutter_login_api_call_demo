import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body:  Center(
        child: /* user != null
            ? Text("Logged IN \n \n Email: ${user.email} ")
            : Text("Yore not Logged IN"), */
            Text("You are loggedin now")
      ),
    );
  }
  }


