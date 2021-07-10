import 'package:flutter/material.dart';
import 'dart:html';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<bool> signup(String username, String password, String passwordRepeat) async {
  var form = new Map<String, dynamic>();
  form['username'] = username;
  form['password'] = password;
  form['password-repeat'] = passwordRepeat;

  final response =
      await http.post(
        Uri.parse('http://0.0.0.0:5000/users'),
        body: form,
      );
  if (response.statusCode == 201) {
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Signup Failed');
  }
}

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();
  String? _token = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:50,bottom: 0),
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
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordRepeatController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
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
                    labelText: 'Repeat Password',
                    hintText: 'Repeat your password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                   final future = signup(userController.text, passwordController.text, passwordRepeatController.text);
                   future.then((token) {
                     print("signup success");
                     final snackBar = SnackBar(
                       content: Text("Signup Successful"),
                     );
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                     Navigator.pop(context);
                   }).catchError((e){
                       print(e);
                       final snackBar = SnackBar(
                         content: Text("Signup Failed"),
                       );
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   });
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
