import 'package:flutter/material.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/EncrypterDecrypter.dart';

class ReceiverChatBox extends StatelessWidget {
  final ChatDataModel chat;
  final String uniqueKey;
  const ReceiverChatBox({Key key, this.chat, this.uniqueKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 7.0,
      ),
      child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            color: chat.senderID == Constant.superUser.uid
                ? Constant.kPrimaryColor
                : Colors.white,
            elevation: 5.0,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 10.0,
                maxWidth: (MediaQuery.of(context).size.width * 0.82),
              ),
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                dynamicDecrypt(uniqueKey, chat.msg),
                softWrap: true,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
