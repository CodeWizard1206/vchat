import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/Models/EncrypterDecrypter.dart';

class Messages extends StatefulWidget {
  Messages({Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Messages...',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                    InkWell(
                      child: Material(
                        color: Constant.kComponentBgColor,
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(
                            12.0,
                          ),
                          child: Icon(
                            FlutterIcons.search_faw5s,
                            color: Constant.kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () => send(),
                      child: Material(
                        color: Constant.kComponentBgColor,
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(
                            12.0,
                          ),
                          child: Icon(
                            FlutterIcons.plus_faw5s,
                            color: Constant.kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamProvider<List<Map<String, dynamic>>>(
                  create: (_) => FirebaseFirestore.instance
                      .collection('testData')
                      .orderBy('timestamp')
                      .snapshots()
                      .map(
                        (snap) => snap.docs.map((e) => e.data()).toList(),
                      ),
                  child: ListItem(),
                ),
                // child: ListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void send() {
    TextEditingController _text = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('send message...'),
        content: Container(
          width: 600.0,
          child: TextFormField(
            controller: _text,
            obscureText: true,
            textAlign: TextAlign.center,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'enter text...',
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.kPrimaryColor,
                  width: 2,
                ),
              ),
            ),
            maxLines: 1,
            onChanged: (value) {},
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              if (_text.text != '') {
                String one = globalEncrypt(_text.text);
                String two = globalEncrypt(one);
                await FirebaseFirestore.instance.collection('testData').add({
                  'message': two,
                  'timestamp': DateTime.now(),
                });
                Navigator.of(context).pop();
              }
            },
            color: Constant.kPrimaryColor,
            child: Text(
              'submit...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  ListItem({Key key}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _data =
        Provider.of<List<Map<String, dynamic>>>(context);
    if (_data != null) {
      return ListView(
        dragStartBehavior: DragStartBehavior.down,
        children: _data.map((string) {
          String one = globalDecrpyt(string['message']);
          String two = globalDecrpyt(one);
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(string['message']),
                SizedBox(
                  height: 20.0,
                ),
                Text(one),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  two,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return SizedBox();
    }
  }
}
