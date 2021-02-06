import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vchat/Constants.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({Key key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool isLoading = false;
  File _image;
  TextEditingController _nameController;
  TextEditingController _dobController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _focusNode = FocusNode();

    _dobController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: this.isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: (MediaQuery.of(context).size.width * 0.4),
                      backgroundImage: _image == null
                          ? AssetImage('assets/images/userImage.png')
                          : FileImage(_image),
                    ),
                  ),
                ),
                TextFormField(
                  controller: this._nameController,
                  focusNode: this._focusNode,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(
                      color: Constant.kPrimaryColor,
                    ),
                    hintText: 'User Name...',
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Constant.kPrimaryDarkColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Constant.kPrimaryColor,
                        width: 3,
                      ),
                    ),
                  ),
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      _dobController.text =
                          DateFormat('dd-MM-yyyy').format(date);
                    });
                  },
                  child: TextFormField(
                    controller: this._dobController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'Date',
                      filled: true,
                      enabled: false,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryDarkColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                          width: 3,
                        ),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    if (this._nameController.text != '') {
                      if (this._focusNode.hasPrimaryFocus) {
                        this._focusNode.unfocus();
                      }
                    }
                  },
                  child: Icon(
                    FlutterIcons.angle_right_faw5s,
                    color: Constant.kPrimaryColor,
                    size: 78,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
