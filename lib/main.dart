import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/PAGES/LoginScreen.dart';
import 'package:vchat/PAGES/Messages.dart';
import 'package:vchat/PAGES/UserInfoScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V Chat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Constant.kPrimaryColor,
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/infoPost': (context) => UserInfoScreen(),
        '/home': (context) => Messages(),
      },
      initialRoute: '/',
    );
  }
}
