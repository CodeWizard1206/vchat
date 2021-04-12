import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vchat/COMPONENTS/LoaderWidget.dart';
import 'package:vchat/COMPONENTS/MessageSenderTile.dart';
import 'package:vchat/COMPONENTS/SenderChatBox.dart';
import 'package:vchat/COMPONENTS/ReeiverChatBox.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';
import 'package:vchat/MODELS/ChatTileModel.dart';
import 'package:vchat/MODELS/EncrypterDecrypter.dart';
import 'package:vchat/MODELS/FirebaseModel.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChatScreen extends StatelessWidget {
  final String uid;
  final String username;
  final String profileImage;
  final String contact;
  const ChatScreen({
    Key key,
    this.uid,
    this.profileImage,
    this.username,
    this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int chatContact =
        int.parse(contact.substring((contact.length - 10), contact.length));

    int myContact = int.parse(Constant.superUser.contact.substring(
        (Constant.superUser.contact.length - 10),
        Constant.superUser.contact.length));

    String chatDbName;
    String uniqueKey;

    if (chatContact < myContact) {
      chatDbName = contact + Constant.superUser.contact;
      uniqueKey = chatDbName + uid + Constant.superUser.uid;
    } else {
      chatDbName = Constant.superUser.contact + contact;
      uniqueKey = chatDbName + Constant.superUser.uid + uid;
    }

    return Scaffold(
      backgroundColor: Constant.kComponentBgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        FlutterIcons.angle_left_faw5s,
                        size: 32.0,
                        color: Constant.kPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        username,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Barty',
                            fontSize: 28),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Constant.kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: CircleAvatar(
                          backgroundColor: Constant.kPrimaryColor,
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamProvider<List<ChatDataModel>>(
          create: (_) => FirebaseModel.getChats(chatDbName),
          child: ChatBody(
            chat: ChatTileModel(
              uid: uid,
              contactName: username,
              contact: contact,
              profileImage: profileImage,
              unread: false,
            ),
            uniqueKey: uniqueKey,
            dbName: chatDbName,
          ),
        ),
      ),
    );
  }
}

class ChatBody extends StatefulWidget {
  final String uniqueKey;
  final ChatTileModel chat;
  final String dbName;
  ChatBody({
    Key key,
    this.uniqueKey,
    this.chat,
    this.dbName,
  }) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  Future<void> onTap(TextEditingController controller) async {
    String msg = dynamicEncrypt(widget.uniqueKey, controller.text);
    widget.chat.message = msg;

    FirebaseModel.sendMessage(widget.chat, widget.dbName);

    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    var _data = Provider.of<List<ChatDataModel>>(context);

    if (_data == null) {
      return Center(
        child: LoaderWidget(),
      );
    } else if (_data.length == 0) {
      return Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          MessageSenderTile(
            onTap: onTap,
          ),
        ],
      );
    } else {
      FirebaseModel.updateUnread(widget.chat.uid);
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: _data
                  .map(
                    (chat) => _data.indexOf(chat) == 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12.0),
                              chat.senderID != Constant.superUser.uid
                                  ? ReceiverChatBox(
                                      chat: chat,
                                      uniqueKey: widget.uniqueKey,
                                    )
                                  : SenderChatBox(
                                      chat: chat,
                                      uniqueKey: widget.uniqueKey,
                                    ),
                            ],
                          )
                        : _data.indexOf(chat) == (_data.length - 1)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  chat.senderID != Constant.superUser.uid
                                      ? ReceiverChatBox(
                                          chat: chat,
                                          uniqueKey: widget.uniqueKey,
                                        )
                                      : SenderChatBox(
                                          chat: chat,
                                          uniqueKey: widget.uniqueKey,
                                        ),
                                  SizedBox(height: 12.0),
                                ],
                              )
                            : chat.senderID != Constant.superUser.uid
                                ? ReceiverChatBox(
                                    chat: chat,
                                    uniqueKey: widget.uniqueKey,
                                  )
                                : SenderChatBox(
                                    chat: chat,
                                    uniqueKey: widget.uniqueKey,
                                  ),
                  )
                  .toList(),
            ),
          ),
          MessageSenderTile(
            onTap: onTap,
          ),
        ],
      );
    }
  }
}
