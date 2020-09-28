import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_demo_flutter/model/user.dart';
import '../homescreen.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // static var baseUrl = "http://techspinsolutions.in/demo/ohho_food";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isUserNameEmpty = false;
  bool isPasswordEmpty = false;
  bool _isLoading = false;

  void isValid() {
    setState(
      () {
        print('Raised button clicked');
        if (emailController.text.isEmpty) {
          print('Is not valid');
          isUserNameEmpty = true;
        } else if (passwordController.text.isEmpty) {
          isUserNameEmpty = false;
          isPasswordEmpty = true;
          print('Is not valid');
        } else {
          print('Is valid');
          _isLoading = true;
          signIn(emailController.text, passwordController.text);
        }
      },
    );
  }

  signIn(String email, String pass) async {
    print('Email-> $email \n Password-> $pass');
    // Map data = {'email': email, 'pass': pass};
    var data = <String, String>{
      'email': email,
      'pass': pass,
    };
    print(data);
    var response = await http.post(
      "http://techspinsolutions.in/demo/ohho_food/login.php",
      body: data,
      /* headers: {'Content-Type': 'application/json'} */
    );
    Map resData = json.decode(response.body);
    print(resData);
    User user = User();
    user = User.fromJson(resData);
    print('User-> $user');
    if (user.status==1) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else if(user.status==0) {
    
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Wrong email or password')));
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }else  {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: _isLoading
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: isUserNameEmpty ? 'Please enter email' : null,
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText:
                          isPasswordEmpty ? 'Please enter password' : null,
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                      child: Text('Login'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        isValid();
                      }),
                ],
              ),
            ),
    );
  }
}
