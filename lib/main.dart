import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/PAGES/LoginScreen.dart';
import 'package:vchat/PAGES/Messages.dart';
import 'package:vchat/PAGES/UserInfoScreen.dart';
import 'package:vchat/PAGES/UserRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      MyApp(
        defaultRoute: '/',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String defaultRoute;

  MyApp({this.defaultRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V Chat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Constant.kPrimaryColor,
      ),
      initialRoute: this.defaultRoute,
      routes: {
        '/': (context) => LoginScreen(),
        '/infoPost': (context) => UserInfoScreen(),
        '/home': (context) => Messages(),
        '/userRegister': (context) => UserRegister(),
      },
    );
  }
}
