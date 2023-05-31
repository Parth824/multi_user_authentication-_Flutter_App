import 'package:flutter/material.dart';
import 'package:multi_user_authentication/helper/sql_helper.dart';
import 'package:multi_user_authentication/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>>? alldata;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController typeEditingController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    alldata = Sql_Helper.sql_helper.fechtallData2();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("$name"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            List<User>? data = snapshot.data;

            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text("${data[index].email}"),
                  subtitle: Text("${data[index].type}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showBox(user: data[index]);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          int k = await Sql_Helper.sql_helper
                              .deleteall(id: data[index].id!);
                          if (k == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Delete  Succfully'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            alldata = Sql_Helper.sql_helper.fechtallData2();
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Update Faild'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  showBox({required User user}) {
    emailEditingController.text = user.email;
    passwordEditingController.text = user.password;
    typeEditingController.text = user.type;

    email = user.email;
    password = user.password;
    type = user.type;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: globalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailEditingController,
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
                    controller: passwordEditingController,
                    textInputAction: TextInputAction.next,
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
                      labelText: "Password",
                      hintText: "Enter Your Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: typeEditingController,
                    textInputAction: TextInputAction.next,
                    onSaved: (val) {
                      type = val!;
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the type";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "type",
                      hintText: "Enter Your type",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                emailEditingController.clear();
                passwordEditingController.clear();
                typeEditingController.clear();

                setState(() {
                  email = "";
                  password = "";
                  type = "";
                });
                Navigator.pop(context);
              },
              child: Text("Remove"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (globalKey.currentState!.validate()) {
                  globalKey.currentState!.save();

                  int k = await Sql_Helper.sql_helper.updateAll(
                      email: email,
                      password: password,
                      type: type,
                      id: user.id!);
                  print(k);
                  if (k == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('UpDate  Succfully'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pop(context);
                    alldata = Sql_Helper.sql_helper.fechtallData2();
                    setState(() {});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Update Faild'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
                emailEditingController.clear();
                passwordEditingController.clear();
                typeEditingController.clear();

                setState(() {
                  email = "";
                  password = "";
                  type = "";
                });
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
