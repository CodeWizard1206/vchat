import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vchat/Models/ChatTileModel.dart';

class ChatTile extends StatelessWidget {
  final ChatTileModel data;
  const ChatTile({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                data.profileImage,
                scale: double.maxFinite,
              ),
            ),
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
                    child: Text(data.contactName),
                  ),
                  Text(
                    DateFormat.jm().format(
                      data.msgTime.toDate(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(data.message),
                  ),
                  Visibility(
                    visible: data.unreadCount > 0,
                    child: Text(
                      data.unreadCount.toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
