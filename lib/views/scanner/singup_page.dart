import 'package:flutter/material.dart';
import 'package:multi_user_authentication/views/scanner/login_page.dart';

import '../../helper/sql_helper.dart';
import '../../models/user_model.dart';

class Singup_Page extends StatefulWidget {
  const Singup_Page({super.key});

  @override
  State<Singup_Page> createState() => _Singup_PageState();
}

class _Singup_PageState extends State<Singup_Page> {
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
              "Hello $name Sing Up",
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
                    List<User> k =
                        await Sql_Helper.sql_helper.fechtallData(email: email);
                    if (k.isEmpty) {
                      int m = await Sql_Helper.sql_helper.InsertallData(
                          email: email, password: password, type: name);

                      if (m > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sing Up Succfully'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Login_Page(),
                              settings: RouteSettings(arguments: name)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Sing Up faile'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Have User'),
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
                child: Text("Sing Up"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Login_Page(),
                      settings: RouteSettings(arguments: name)),
                );
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Alread Have Accout?",
                    ),
                    TextSpan(
                      text: "Sing In",
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
