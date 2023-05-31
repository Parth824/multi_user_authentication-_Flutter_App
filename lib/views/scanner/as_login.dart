import 'package:flutter/material.dart';
import 'package:multi_user_authentication/views/scanner/login_page.dart';

class As_Login extends StatefulWidget {
  const As_Login({super.key});

  @override
  State<As_Login> createState() => _As_LoginState();
}

class _As_LoginState extends State<As_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("multi-user authentication"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/user3.png",
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                            settings: RouteSettings(arguments: 'Admin'),
                          ),
                        );
                      },
                      child: Text("Admin"),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                            settings: RouteSettings(arguments: 'Manager'),
                          ),
                        );
                      },
                      child: Text("Manager"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                            settings: RouteSettings(arguments: 'Clerk'),
                          ),
                        );
                      },
                      child: Text("Clerk"),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                            settings: RouteSettings(arguments: 'Employee'),
                          ),
                        );
                      },
                      child: Text("Employee"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
