import 'package:flutter/material.dart';
import 'package:multi_user_authentication/helper/sql_helper.dart';
import 'package:multi_user_authentication/views/scanner/homepage.dart';
import 'package:multi_user_authentication/views/scanner/singup_page.dart';

import '../../models/user_model.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/singin.png",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Hello $name",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailtextEditingController,
                        textInputAction: TextInputAction.next,
                        onSaved: (val) {
                          email = val!;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Email";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter Your Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordtextEditingController,
                        textInputAction: TextInputAction.done,
                        onSaved: (val) {
                          password = val!;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Password";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "PassWord",
                          hintText: "Enter Your PassWord",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();

                    List<User> m = await Sql_Helper.sql_helper
                        .fechtallData1(password: password, email: email);
                    if (m.isNotEmpty) {
                      if (m[0].type == name) {
                        if (m[0].email == email) {
                          if (m[0].password == password) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sing In Succfully'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                  settings: RouteSettings(arguments: name)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Password Not machts'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Emaile is invailde'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('This is Not $name'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('NoT Have User'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                  emailtextEditingController.clear();
                  passwordtextEditingController.clear();
                  setState(() {
                    email = "";
                    password = "";
                  });
                },
                child: Text("Login"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Singup_Page(),
                    settings: RouteSettings(arguments: name),
                  ),
                );
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Not Have any Accout?",
                    ),
                    TextSpan(
                      text: "Sing Up",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
