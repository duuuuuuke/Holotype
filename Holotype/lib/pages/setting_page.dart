import 'package:demo1/pages/tabs/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Top(),
          Img(),
          Name(),
          Expanded(child: SettingList()),
          Logout()
        ],
      ),
    );
  }
}

// Basic icons
class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
      height: 80,
      width: 400,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Row(
        children: [
          // SizedBox(
          //   height: 150,
          //   width: 30,
          // ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color.fromARGB(255, 44, 94, 70),
              )),
          Text(
            "                  Messages",
            style: TextStyle(
                fontFamily: 'Fatface',
                color: Color.fromARGB(255, 44, 94, 70),
                fontSize: 28),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}

// image of user
class Img extends StatelessWidget {
  const Img({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.red),
          image: DecorationImage(
              image: AssetImage("assets/img/img.png"), fit: BoxFit.contain),
          color: Colors.white,
          shape: BoxShape.circle),
    );
  }
}

// Name of user
class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 30,
      width: 400,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Center(
          child: Text(
        "Agnes Don",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}

// ListView in setting page
class SettingList extends StatelessWidget {
  const SettingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This feature is under development!");
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security'),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This feature is under development!");
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Display and languages'),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This feature is under development!");
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This feature is under development!");
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Log out Button
class Logout extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    User? user = _auth.getCurrentUserInfo();

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const Authenticate();
            }));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            backgroundColor: Colors.orange,
          ),
          child: Text(
            "LOG OUT",
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),
    );
  }
}
