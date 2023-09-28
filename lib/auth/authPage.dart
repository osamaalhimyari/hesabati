import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hesabi_app/auth/SignUpPage.dart';
import 'package:hesabi_app/main.dart';
import 'package:hesabi_app/models/routes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> authFormState = GlobalKey();

  TextEditingController? number = TextEditingController();

  TextEditingController? password = TextEditingController();

  // UserAuthClass user = UserAuthClass();

  @override
  Widget build(BuildContext context) {
    // widget.number == null ? '' : widget.number;
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
                    child: Text('Sign in'),
                  ),
                  TextFormField(
                    controller: number,
                    validator: (String? value) {
                      if (password!.text != users.first['password'] ||
                          value != users.first['number']) {
                        return 'wrong password or number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'enter your  number.',
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
                    validator: (String? value) {
                      if (value != users.first['password'] ||
                          number!.text != users.first['number']) {
                        return 'wrong password or number';
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
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      if (authFormState.currentState!.validate()) {
                        setState(() {
                          isVerified = true;
                        });

                        // sysRouting(context, InitApp());
                        // Navigator.of(context).pushReplacementNamed('homePage');
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
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          sysRouting(context, SignUpPage());
                        },
                        child: Text(
                          "dont have account?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ButtonMenue extends StatelessWidget {
  ButtonMenue({super.key});
  final List<String> lang = [
    'english',
    'العربية',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    selectedValue ??= lang.first;
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 30),
              DropdownButtonFormField2<String>(
                // isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  selectedValue!,
                  style: TextStyle(fontSize: 14),
                ),
                items: lang
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),

                onChanged: (value) {
                  selectedValue = value;
                  _formKey.currentState!.save();
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              // const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
