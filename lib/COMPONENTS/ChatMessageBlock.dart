import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vchat/COMPONENTS/ChatDateBox.dart';
import 'package:vchat/COMPONENTS/ReeiverChatBox.dart';
import 'package:vchat/COMPONENTS/SenderChatBox.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';

// ignore: must_be_immutable
class ChatMessageBlock extends StatelessWidget {
  final List<ChatDataModel> dataList;
  final ChatDataModel currentChat;
  final String uniqueKey;
  final String image;

  int currentIndex;
  int nextIndex;
  int previousIndex;

  bool itsMe;
  ChatMessageBlock({
    Key key,
    this.dataList,
    this.currentChat,
    this.uniqueKey,
    this.image,
  }) : super(key: key) {
    currentIndex = dataList.indexOf(currentChat);
    nextIndex = currentIndex + 1;
    previousIndex = currentIndex - 1;

    itsMe = currentChat.senderID != Constant.superUser.uid;
  }

  bool doAddDate(bool isLast) {
    if (isLast) {
      return true;
    } else {
      return (dataList
                  .elementAt(nextIndex)
                  .msgDate
                  .difference(currentChat.msgDate)
                  .inMinutes >
              5 ||
          currentChat.senderID != dataList.elementAt(nextIndex).senderID);
    }
  }

  bool doAddSeenStatus(bool isLast) {
    if (isLast) {
      return currentChat.senderID != Constant.superUser.uid;
    } else {
      return currentChat.senderID != Constant.superUser.uid &&
          currentChat.senderID != dataList.elementAt(nextIndex).senderID;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          itsMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        SizedBox(height: currentIndex == 0 ? 12.0 : 0.0),
        ChatDateBox(
          first: currentIndex != 0
              ? dataList.elementAt(previousIndex).msgDate
              : DateTime.now(),
          second: currentChat.msgDate,
        ),
        itsMe
            ? ReceiverChatBox(
                chat: currentChat,
                uniqueKey: uniqueKey,
              )
            : SenderChatBox(
                chat: currentChat,
                uniqueKey: uniqueKey,
              ),
        doAddDate(currentIndex == (dataList.length - 1))
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    doAddSeenStatus(currentIndex == (dataList.length - 1))
                        ? CircleAvatar(
                            radius: 7.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: image != null
                                ? NetworkImage(image)
                                : AssetImage('assets/images/user.png'),
                          )
                        : SizedBox(),
                    SizedBox(width: 4.0),
                    Text(
                      DateFormat.jm().format(currentChat.msgDate),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        SizedBox(height: currentIndex == (dataList.length - 1) ? 12.0 : 0.0),
      ],
    );
  }
}
