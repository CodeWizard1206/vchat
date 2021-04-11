import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatTileModel.dart';
import 'package:vchat/PAGES/ChatScreen.dart';

class ChatTile extends StatelessWidget {
  final ChatTileModel data;
  const ChatTile({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              uid: data.uid,
              username: data.contactName,
              contact: data.senderID,
              profileImage: data.profileImage,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: data.profileImage != null
                    ? NetworkImage(
                        data.profileImage,
                      )
                    : AssetImage('assets/images/user.png'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.contactName,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(DateTime.now()) ==
                                DateFormat('dd').format(data.msgTime)
                            ? DateFormat.jm().format(data.msgTime)
                            : data.msgTime.difference(DateTime.now()).inHours <
                                    48
                                ? 'Yesterday'
                                : DateFormat('dd/MM/yy').format(data.msgTime),
                        style: TextStyle(
                          color: data.unread
                              ? Constant.kPrimaryColor
                              : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.message,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: data.unread
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 16,
                            color: data.unread
                                ? Constant.kPrimaryColor
                                : Colors.black45,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: data.unread,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Constant.kPrimaryColor,
                            child: Container(
                              height: 15.0,
                              width: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
