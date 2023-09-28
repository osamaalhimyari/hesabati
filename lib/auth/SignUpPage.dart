// import 'package:hesabi_app/auth/Animation/FadeAnimation.dart';
import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hesabi_app/auth/authPage.dart';
import 'package:hesabi_app/main.dart';
import 'package:hesabi_app/models/routes.dart';

import '../models/UserModel.dart';
import 'UserProfile.dart';
// import 'package:hesabi_app/models/routes.dart';
// import 'package:hesabi_app/pages/homepage.dart';
// import 'package:hesabi_app/auth/Animation/FadeAnimation.dart';
// import 'package:path/path.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> authFormState = GlobalKey();

  TextEditingController number = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController CPassword = TextEditingController();

  // UserAuthClass user = UserAuthClass();

  // String? newPassword;

  // late int id;
  // count() async {
  //   int r = await sqlDb.count('user');
  //   id = r;
  //   setState(() {});
  //   print(r);
  // }

  // @override
  // void initState() {
  //   count();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 150,
          leading: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: ButtonMenue()),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Form(
              key: authFormState,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    child: Text('Sign Up'),
                  ),
                  TextFormField(
                    controller: number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mumber';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'enter your email or mumber.',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: password,
                    onChanged: (value) {
                      password.text = value;
                    },
                    validator: (String? value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter password';
                      // }
                      if (value != CPassword.text) {
                        return 'passwords does not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'Enter Your password.',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: CPassword,
                    onChanged: (value) {},
                    validator: (String? value) {
                      if (value != password.text) {
                        return 'passwords does not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'confirm Your password.',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      if (authFormState.currentState!.validate()) {
                        print('==================');
                        // print(password.text);
                        // print(number.text);

                        int response = await sqlDb.insertData('user', {
                          'name': 'user',
                          'number': "${number.text}",
                          'password': "${password.text}",
                        });

                        if (response > 0) {
                          setState(() {
                            // user.password = ;
                            // user.number =;
                            // user.state = true;
                          });
                          print(response);
                          print('==added ================');

                          // sysRouting(context, UserProfilePage(id: 1));

                          // sysRouting(
                          //     context, AuthPage(0, number.text, password.text));
                        }

                        if (Duration(seconds: 5).inSeconds != 5) {
                          CircularProgressIndicator();
                        } else {}
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(71, 78, 205, 1),
                            Color.fromRGBO(40, 44, 135, 0.6),
                          ])),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "you do have an account?",
                      style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
