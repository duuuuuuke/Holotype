import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';
import 'package:demo1/pages/tabs/services/auth_services.dart';
import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/Expert/ExpertTabs.dart';
import 'package:demo1/sign_up_success.dart';
import 'package:demo1/pages/tabs/map/offline_map.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Store input of email and password.
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context);

    // Check if user is log in now.
    if (user == null) {
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            //background image
            Opacity(
              opacity: 0.5,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/homepage.jpg"))),
              ),
            ),

            SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "holotype",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Georgia",
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 75,
                  ),
                  //username
                  SizedBox(
                    width: 300,
                    height: 200,
                    child: ListView(
                      children: [
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an username' : null,
                          onChanged: (val) {
                            setState(() => username = val);
                          },
                          autofocus: false,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.account_box),
                              hintText: "Username",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //email address
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.email),
                              hintText: "Email address",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //password
                        TextFormField(
                            validator: (val) => val!.length < 6
                                ? 'Enter a password longer than 6 characters'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            autofocus: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              icon: const Icon(Icons.lock),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ))
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 75,
                  ),
                  //sign up button
                  Container(
                      width: 300,
                      height: 60,
                      color: Colors.orange,
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Display loading widget.
                            setState(() => loading = true);
                            // ignore: unused_local_variable
                            dynamic result = await _auth.registerEmailPassoword(
                                email, password, username);
                            // Check if registration is success.
                            if (result == null) {
                              setState(() {
                                error = 'please enter a valid email';
                                loading = false;
                              });
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const SignUpSuccess();
                              }));
                            }
                          }
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      )),
                  //offline map
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      width: 300,
                      height: 60,
                      color: Color.fromARGB(255, 141, 84, 0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const OfflineMap();
                          }));
                        },
                        child: const Text(
                          "Offline Map",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      )),

                  const SizedBox(
                    height: 30,
                  ),
                  //back to home page
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Authenticate();
                      }));
                    },
                    child: const Icon(Icons.home),
                  )
                ],
              ),
            ))
          ],
        ),
      );
    } else if (user.uid == "G6nq0lI5Ppej44JeOyKkJNtwQox1") {
      return ExpertTabs();
    } else {
      return Tabs();
    }
  }
}
