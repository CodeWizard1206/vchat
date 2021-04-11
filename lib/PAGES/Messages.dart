import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/Models/ChatTileModel.dart';
import 'package:vchat/Models/FirebaseModel.dart';
import 'package:vchat/Models/UserModel.dart';
import 'package:vchat/COMPONENTS/AddChatPop.dart';
import 'package:vchat/COMPONENTS/NonUserTile.dart';
import 'package:vchat/COMPONENTS/ExistingUserTile.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamProvider<List<ChatTileModel>>(
              create: (_) => FirebaseModel.getAllChats(),
              child: MessagesHome()),
        ),
      ),
    );
  }
}

class MessagesHome extends StatefulWidget {
  MessagesHome({Key key}) : super(key: key);

  @override
  _MessagesHomeState createState() => _MessagesHomeState();
}

class _MessagesHomeState extends State<MessagesHome> {
  Future<void> newChat(BuildContext context) async {
    List<UserModel> _users = await FirebaseModel.getContactList();
    var permission = await Permission.contacts.request().isGranted;

    if (permission) {
      List<String> contact = [];
      List<Map<String, dynamic>> nonUsers = [];
      Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);

      for (Contact c in contacts) {
        Iterable<Item> phone = c.phones;

        for (Item i in phone) {
          String num = i.value.replaceAll('-', '').replaceAll(' ', '');
          if (num.length >= 10) {
            num = num.substring((num.length - 10), num.length);
            // if (!contacts.contains(num)) {
            contact.add(num);
            Map<String, dynamic> map = {
              'name': c.displayName,
              'contact': num,
            };
            nonUsers.add(map);
            // }
          }
        }
      }

      contact = contact.toSet().toList();

      _users = _users.where((user) {
        String con = user.contact;
        con = con.substring((con.length - 10), con.length);

        if (contact.contains(con)) {
          contact.remove(con);
          return true;
        } else {
          return false;
        }
      }).toList();

      nonUsers = nonUsers
          .where((element) => contact.contains(element['contact']))
          .toList();

      List<dynamic> _displayList =
          _users.map((user) => ExistingUserTile(user: user)).toList();

      List<Widget> _nonList = [];

      for (Map<String, dynamic> non in nonUsers) {
        _nonList.add(
          NonUserTile(user: non),
        );
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        builder: (_) => AddChatPop(
          existingUsers: _displayList,
          nonUsers: _nonList,
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Permission request denied!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var _chats = Provider.of<List<ChatTileModel>>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: Constant.superUser.image != null
                        ? NetworkImage(Constant.superUser.image)
                        : AssetImage('assets/images/user.png'),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Material(
                color: Constant.kComponentBgColor,
                borderRadius: BorderRadius.circular(16.0),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      FlutterIcons.search_faw5s,
                      color: Constant.kPrimaryColor,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Material(
                color: Constant.kComponentBgColor,
                borderRadius: BorderRadius.circular(16.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    newChat(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      FlutterIcons.plus_faw5s,
                      color: Constant.kPrimaryColor,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _chats == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(Constant.kPrimaryColor),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        'Please Wait...',
                        style: TextStyle(
                          fontFamily: 'Barty',
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                )
              : _chats.length == 0
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icon.png',
                            width: (MediaQuery.of(context).size.width * 0.75),
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontFamily: 'Haydes',
                              fontSize: 62.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
        ),
      ],
    );
  }
}
