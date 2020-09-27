import 'dart:convert';

import 'package:flutter/material.dart';
import '../homescreen.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

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

  /* static BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (status) {
        if (status >= 1) {
          return true;
        }
      });
  static Dio dio = Dio(options);
 */
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
          /* setState(
            () async {
              print('Raised button clicked');
              _isLoading = true;
              var response = await _loginUser(
                  emailController.text, passwordController.text);
              setState(() => _isLoading = false);

              User user = User.fromJson(response);
              if (user != null) {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new HomeScreen();
                }));
              } else {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Wrong email or")));
              }
            },
          ); */
          signIn(emailController.text, passwordController.text);
        }
      },
    );
  }

  signIn(String email, String pass) async {
    User user = User();
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
        /* headers: {'Content-Type': 'application/json'} */);
    var resData = json.decode(response.body);
    // user = User.fromJson(resData);
    print(resData);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  /* Future<dynamic> _loginUser(String email, String password) async {
    try {
      // Options options = Options(
      //   contentType: ContentType.parse('application/json'),
      // );

      Response response = await dio
          .post('/login.php', data: {"email": email, "pass": password});

      if (response.statusCode == 1) {
        var responseJson = json.decode(response.data);
        return responseJson;
      } else if (response.statusCode == 0) {
        print('Incorrect Email/Password');
        throw Exception("Incorrect Email/Password");
      } else
        throw Exception('Authentication Error');
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  } */

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
