import 'package:demo1/pages/tabs/Expert/ExpertTabs.dart';
import 'package:demo1/pages/tabs/camera001.dart';
import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tabs/Home.dart';
import './tabs/User_Profile.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 2;
  //three main pages in Tabs page
  List _pages = [HomePage(), Camera001(), UserProfilePage()];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context);
    if (user?.uid == null) {
      return Authenticate();
    } else if (user?.uid == "G6nq0lI5Ppej44JeOyKkJNtwQox1") {
      return ExpertTabs();
    } else {
      return Container(
        child: Scaffold(
          body: _pages[_currentIndex],
          // BottomNavigationBar
          bottomNavigationBar: BottomNavigationBar(
              iconSize: 35,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload), label: "Upload"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me")
              ]),
        ),
      );
    }
  }
}
