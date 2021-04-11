import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vchat/COMPONENTS/LoaderWidget.dart';
import 'package:vchat/COMPONENTS/MessageSenderTile.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';
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

    int myContact = int.parse(contact.substring(
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
            uniqueKey: uniqueKey,
          ),
        ),
      ),
    );
  }
}

class ChatBody extends StatefulWidget {
  final String uniqueKey;
  ChatBody({Key key, this.uniqueKey}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
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
          MessageSenderTile(),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          MessageSenderTile(),
        ],
      );
    }
  }
}
