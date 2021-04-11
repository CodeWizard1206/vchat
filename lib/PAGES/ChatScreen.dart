import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vchat/COMPONENTS/LoaderWidget.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';
import 'package:vchat/MODELS/FirebaseModel.dart';

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
      body: SafeArea(
        child: StreamProvider<List<ChatDataModel>>(
          create: (_) => FirebaseModel.getChats(chatDbName),
          child: ChatBody(),
        ),
      ),
    );
  }
}

class ChatBody extends StatefulWidget {
  ChatBody({Key key}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  TextEditingController _controller = TextEditingController();
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
          Container(
            padding: const EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Constant.kPrimaryColor,
                    controller: this._controller,
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Constant.kPrimaryColor,
                    controller: this._controller,
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
