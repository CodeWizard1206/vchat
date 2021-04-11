import 'package:flutter/material.dart';
import 'package:vchat/Models/UserModel.dart';

class Constant {
  static const kPrimaryColor = Color(0xFF76BCFF); //Color(0xFF2196F3);
  static const kPrimaryDarkColor = Color(0xFF373435);
  static final kComponentBgColor = Colors.grey[200];
  static final UserModel superUser = UserModel(
    contact: '',
    image: null,
    username: '',
    joinedOn: DateTime.now(),
  );

  // static void showFlushBar({
  //   String title,
  //   BuildContext context,
  //   bool alertStyle = false,
  //   String message = 'Please wait for sometime or Try again ',
  // }) {
  //   Flushbar(
  //     maxWidth: 500.0,
  //     margin: const EdgeInsets.all(10.0),
  //     borderRadius: 8.0,
  //     backgroundGradient: LinearGradient(
  //       colors: alertStyle
  //           ? [Colors.red[600], Colors.red[600]]
  //           : [kPrimaryColor, kPrimaryColor],
  //       stops: [0.5, 1],
  //     ),
  //     boxShadows: [
  //       BoxShadow(
  //         color: Colors.black45,
  //         offset: Offset(4, 4),
  //         blurRadius: 8,
  //       ),
  //     ],
  //     barBlur: 3.0,
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  //     title: title,
  //     message: message,
  //     duration: Duration(seconds: 3),
  //   )..show(context);
  // }
}
