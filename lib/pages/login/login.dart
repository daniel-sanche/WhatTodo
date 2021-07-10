import 'package:flutter/material.dart';
import 'dart:html';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/login/signup.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/auth/auth.dart';
import 'package:provider/provider.dart';

Future<String> login(String username, String password) async {
  final response =
      await http.get(
              Uri.parse('http://0.0.0.0:5000/login?username='+username+'&password='+password),
      );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonPayload = jsonDecode(response.body);
    return jsonPayload['token'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Login Failed');
  }
}

class LoginPage extends StatefulWidget {

  const LoginPage({
    Key? key,
    this.homepage = const Text("logged in!"),
  }) : super(key: key);

  final Widget homepage;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String? _token = null;

  @override
  Widget build(BuildContext context) {
    // build login screen if not authenticated. Otherwise, load home page
    return Consumer<AuthData>(
        builder: (context, auth, child) {
            if (auth.isAuthenticated){
                // already logged on
                return widget.homepage;
            } else {
                return buildLoginPage(context);
            }
        });
    }

  Widget buildLoginPage(BuildContext context){
    // construct login page widget
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/flutter-logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 50),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                   final future = login(userController.text, passwordController.text);
                   future.then((token) {
                     print("login success");
                     AuthData.get().authenticate(token, "1");
                   }).catchError((e){
                       print(e);
                       final snackBar = SnackBar(
                         content: Text("Login Failed"),
                       );
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   });
            },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            FlatButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
              },
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
