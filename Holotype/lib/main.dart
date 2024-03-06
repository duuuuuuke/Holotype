import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/screens/wrapper.dart';
import 'package:demo1/pages/tabs/services/auth_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DECOUser?>.value(
      // User stream to listen the log in state of the user.
      value: AuthServices().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      )
    );
  }
}