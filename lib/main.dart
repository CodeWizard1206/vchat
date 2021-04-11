import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/PAGES/LoginScreen.dart';
import 'package:vchat/PAGES/ChatHomeScreen.dart';
import 'package:vchat/PAGES/UserRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _cache = await SharedPreferences.getInstance();

  String defaultRoute = '/';
  try {
    if (_cache.getBool('loggedIn')) {
      defaultRoute = '/home';
      print(_cache.getString('userData'));
      Map<String, dynamic> _data = json.decode(_cache.getString('userData'));

      Constant.superUser.uid = _data['uid'];
      Constant.superUser.contact = _data['contact'];
      Constant.superUser.username = _data['username'];
      Constant.superUser.image = _data['image'];
      Constant.superUser.joinedOn = DateTime.parse(_data['joinedOn']);
    }
  } catch (e) {
    print(e.toString());
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      MyApp(
        defaultRoute: defaultRoute,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
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
        '/home': (context) => ChatHomeScreen(),
        '/userRegister': (context) => UserRegister(),
      },
    );
  }
}
