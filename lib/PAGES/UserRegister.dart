import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/Models/FirebaseModel.dart';

class UserRegister extends StatelessWidget {
  const UserRegister({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserRegisterHome(),
    );
  }
}

class UserRegisterHome extends StatefulWidget {
  UserRegisterHome({Key key}) : super(key: key);

  @override
  _UserRegisterHomeState createState() => _UserRegisterHomeState();
}

class _UserRegisterHomeState extends State<UserRegisterHome> {
  double height, width;
  bool started;
  FocusNode _focus;
  TextEditingController _controller;
  File userImage;
  bool isLoading;

  @override
  void initState() {
    started = false;
    isLoading = false;
    _focus = FocusNode();
    _controller = TextEditingController();

    if (Constant.superUser.username != '') {
      _controller.text = Constant.superUser.username;
    }
    super.initState();
  }

  Future<void> setUserImage(BuildContext context, PickedFile image) async {
    if (image.path.toString().contains('.jpg') ||
        image.path.toString().contains('.JPG') ||
        image.path.toString().contains('.png') ||
        image.path.toString().contains('.PNG') ||
        image.path.toString().contains('.jpeg') ||
        image.path.toString().contains('.JPEG')) {
      File _cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Constant.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
        ),
      );

      if (_cropped != null) {
        setState(() {
          this.userImage = _cropped;
        });
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Image with invalid format selected!!!'),
      ));
    }
  }

  Future<void> register(BuildContext context) async {
    if (_focus.hasPrimaryFocus) {
      _focus.unfocus();
    }

    if (_controller.text != '') {
      setState(() {
        isLoading = true;
      });
      if (Constant.superUser.username == '') {
        bool result = await FirebaseModel.registerUser(
            _controller.text, userImage != null, userImage);

        if (result) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).popAndPushNamed('/home');
        } else {
          setState(() {
            isLoading = false;
          });
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Failed to register user, try again!'),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!started) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      started = !started;
    }
    return ModalProgressHUD(
      inAsyncCall: this.isLoading,
      opacity: 0.5,
      progressIndicator: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Constant.kPrimaryColor),
          ),
          SizedBox(
            height: 13,
          ),
          Text(
            'Please Wait...',
            style: TextStyle(
              fontFamily: 'Barty',
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      child: SafeArea(
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
                      autofocus: Constant.superUser.username == '',
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
                            backgroundImage: userImage != null
                                ? FileImage(userImage)
                                : Constant.superUser.image != null
                                    ? NetworkImage(Constant.superUser.image)
                                    : AssetImage('assets/images/user.png'),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Constant.kPrimaryColor,
                          onPressed: () {
                            if (_focus.hasPrimaryFocus) {
                              _focus.unfocus();
                            }
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              builder: (_) => Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    (Constant.superUser.image != null ||
                                            userImage != null)
                                        ? ListTile(
                                            leading:
                                                Icon(FlutterIcons.close_faw),
                                            title: Text('Remove Image'),
                                            onTap: () {
                                              Constant.superUser.image = '';
                                              userImage = null;
                                            },
                                          )
                                        : SizedBox(),
                                    ListTile(
                                      leading: Icon(FlutterIcons.camera_faw),
                                      title: Text('Take a Image'),
                                      onTap: () async {
                                        ImagePicker _picker = ImagePicker();
                                        PickedFile _image =
                                            await _picker.getImage(
                                          source: ImageSource.camera,
                                        );

                                        if (_image != null) {
                                          setUserImage(context, _image);
                                        }
                                        Navigator.of(_).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(FlutterIcons.photo_faw),
                                      title: Text('Add a Image'),
                                      onTap: () async {
                                        ImagePicker _picker = ImagePicker();
                                        PickedFile _image =
                                            await _picker.getImage(
                                          source: ImageSource.gallery,
                                        );

                                        if (_image != null) {
                                          setUserImage(context, _image);
                                        }
                                        Navigator.of(_).pop();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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
                    register(context);
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
