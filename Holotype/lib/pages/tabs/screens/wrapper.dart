import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/Expert/ExpertTabs.dart';
import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context);

    // Check if user is log in now.
    if (user == null) {
      return const Authenticate();
    }
    //expert check
    else if (user.uid == "G6nq0lI5Ppej44JeOyKkJNtwQox1") {
      return ExpertTabs();
    } else {
      return Tabs();
    }
  }
}
