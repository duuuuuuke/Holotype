import 'package:provider/provider.dart';

import "package:flutter/material.dart";

import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/log_in_page.dart';
import 'package:demo1/sign_up_page.dart';
import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/Expert/ExpertTabs.dart';

// Authentication.
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    // Get user information.
    final user = Provider.of<DECOUser?>(context);

    // Check if user is log in now.
    if (user == null) {
      return Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/img/homepage.jpg"))),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Title
              const Text(
                "holotype",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Georgia",
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 60,
              ),
              //log in button
              Container(
                  width: 300,
                  height: 60,
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const LogInPage();
                      }));
                    },
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  )),

              const SizedBox(
                height: 30,
              ),
              //sign up page
              Container(
                  width: 300,
                  height: 60,
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SignUpPage();
                      }));
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  )),
            ],
          )
        ],
      ));
    } else if (user.uid == "G6nq0lI5Ppej44JeOyKkJNtwQox1") {
      return ExpertTabs();
    } else {
      return Tabs();
    }
  }
}
