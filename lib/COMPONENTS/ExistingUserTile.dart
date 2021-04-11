import 'package:flutter/material.dart';
import 'package:vchat/Constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vchat/Models/UserModel.dart';

class ExistingUserTile extends StatelessWidget {
  final UserModel user;
  const ExistingUserTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(user.image),
              radius: 24,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  user.username.replaceFirst(' ', '\n'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Icon(
              FlutterIcons.send_fea,
              color: Constant.kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
