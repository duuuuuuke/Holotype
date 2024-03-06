import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Top(), Img(), Name(), Expanded(child: MessageList())],
      ),
    );
  }
}

class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
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
            "                     Messages",
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

class Img extends StatelessWidget {
  const Img({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('Friends'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Comments'),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    );
  }
}
