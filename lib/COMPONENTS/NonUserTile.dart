import 'package:flutter/material.dart';
import 'package:vchat/Constants.dart';

class NonUserTile extends StatelessWidget {
  final Map<String, dynamic> user;
  const NonUserTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/user.png'),
            radius: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      user['name'],
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Ubuntu',
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Text(
                    user['contact'],
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
          RawMaterialButton(
            onPressed: () {},
            constraints: BoxConstraints(minHeight: 0, minWidth: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 0,
            fillColor: Constant.kPrimaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                'Invite',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
