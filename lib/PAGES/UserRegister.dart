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
  bool started = false;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

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
                      controller: _controller,
                      focusNode: _focus,
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'who are you...',
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
                      vertical: 12.0,
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 6.0),
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
