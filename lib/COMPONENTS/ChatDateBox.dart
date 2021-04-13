import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vchat/Constants.dart';

class ChatDateBox extends StatelessWidget {
  final DateTime first;
  final DateTime second;
  const ChatDateBox({
    Key key,
    this.first,
    this.second,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateFormat('dd').format(first) == DateFormat('dd').format(second)
        ? SizedBox()
        : Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5.0),
            child: Material(
              borderRadius: BorderRadius.circular(13.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  DateFormat('dd').format(DateTime.now()) ==
                          DateFormat('dd').format(second)
                      ? 'TODAY'
                      : DateTime.now().difference(second).inHours < 48
                          ? 'Yesterday'
                          : DateFormat('dd/MM/yy').format(second),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Constant.kPrimaryColor,
                  ),
                ),
              ),
            ),
          );
  }
}
