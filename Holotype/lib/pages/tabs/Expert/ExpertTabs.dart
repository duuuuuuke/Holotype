import 'package:demo1/pages/tabs/Expert/ExpertHome.dart';
import 'package:demo1/pages/tabs/Expert/ExpertUserProfile.dart';
import 'package:flutter/material.dart';

class ExpertTabs extends StatefulWidget {
  const ExpertTabs({super.key});

  @override
  State<ExpertTabs> createState() => _ExpertTabsState();
}

class _ExpertTabsState extends State<ExpertTabs> {
  int _currentIndex = 1;
  List _pages = [ExpertHomePage(), ExpertUserProfilePage()];

  @override
  Widget build(BuildContext context) {
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
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me")
            ]),
      ),
    );
  }
}
