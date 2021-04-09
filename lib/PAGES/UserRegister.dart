import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vchat/Constants.dart';

class UserRegister extends StatefulWidget {
  final userContact;
  UserRegister({
    Key key,
    this.userContact,
  }) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  double height, width;
  bool started;
  FocusNode _focus;
  TextEditingController _controller;

  @override
  void initState() {
    started = false;
    _focus = FocusNode();
    _controller = TextEditingController();
    super.initState();
  }

  Future<void> setUserImage() async {}

  @override
  Widget build(BuildContext context) {
    if (!started) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      started = !started;
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: TextFormField(
                      cursorColor: Constant.kPrimaryColor,
                      controller: _controller,
                      focusNode: _focus,
                      style: TextStyle(
                        fontFamily: 'Barty',
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'who are you...',
                        hintStyle: TextStyle(),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      maxLines: 1,
                      onChanged: (value) {
                        if (value != '') {}
                      },
                    ),
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            radius: (width * 0.35),
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Constant.kPrimaryColor,
                          onPressed: () {},
                          child: Icon(
                            FlutterIcons.add_a_photo_mdi,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                RawMaterialButton(
                  fillColor: Constant.kPrimaryColor,
                  onPressed: () {
                    if (_focus.hasPrimaryFocus) {
                      _focus.unfocus();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9.0,
                      horizontal: 19,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Barty',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(width: 9.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FlutterIcons.rightcircle_ant,
                              color: Colors.white,
                            ),
                            SizedBox(height: 2.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
