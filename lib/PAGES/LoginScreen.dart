import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vchat/COMPONENTS/OTPSheet.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/Models/FirebaseModel.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _codeController;
  TextEditingController _numberController;
  List<DropdownMenuItem> _code = [];
  bool isLoading = false;
  FocusNode _numberFocus = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _codeController = TextEditingController();
    _numberController = TextEditingController();

    List<String> _data = [
      '+91',
      '+92',
      '+93',
      '+98',
      '+27',
      '+82',
      '+34',
      '+94',
      '+01'
    ];

    _data.forEach((code) {
      _code.add(
        DropdownMenuItem(
          value: code,
          child: Text(
            code,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      );
    });
    _codeController.text = _code[0].value;
    super.initState();
  }

  void loggingIn(String phoneNumber) async {
    TextEditingController _one = TextEditingController();
    TextEditingController _two = TextEditingController();
    TextEditingController _three = TextEditingController();
    TextEditingController _four = TextEditingController();
    TextEditingController _five = TextEditingController();
    TextEditingController _six = TextEditingController();

    FocusNode _focusOne = FocusNode();
    FocusNode _focusTwo = FocusNode();
    FocusNode _focusThree = FocusNode();
    FocusNode _focusFour = FocusNode();
    FocusNode _focusFive = FocusNode();
    FocusNode _focusSix = FocusNode();

    try {
      _auth.verifyPhoneNumber(
        timeout: const Duration(
          seconds: 120,
        ),
        phoneNumber: phoneNumber,
        verificationCompleted: (credentials) async {
          String smsCode = credentials.smsCode;

          Future.delayed(
            Duration(
              seconds: 2,
            ),
            () {
              _one.text = smsCode.substring(0, 1);
              _two.text = smsCode.substring(1, 2);
              _three.text = smsCode.substring(2, 3);
              _four.text = smsCode.substring(3, 4);
              _five.text = smsCode.substring(4, 5);
              _six.text = smsCode.substring(5, 6);

              Future.delayed(Duration(seconds: 2), () async {
                setState(() {
                  this.isLoading = true;
                });

                bool result =
                    await FirebaseModel.getUserAuth(credentials, phoneNumber);

                if (result) {
                  Navigator.of(context).pop();
                  setState(() {
                    this.isLoading = false;
                  });
                  Navigator.of(context).popAndPushNamed('/userRegister');
                } else {
                  setState(() {
                    this.isLoading = false;
                  });
                }
              });
            },
          );
        },
        verificationFailed: (exception) async {
          print(exception.phoneNumber);
        },
        codeSent: (verifyID, resendToken) async {
          setState(() {
            this.isLoading = false;
          });

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            builder: (_) {
              return OTPSheet(
                controllerOne: _one,
                controllerTwo: _two,
                controllerThree: _three,
                controllerFour: _four,
                controllerFive: _five,
                controllerSix: _six,
                focusOne: _focusOne,
                focusTwo: _focusTwo,
                focusThree: _focusThree,
                focusFour: _focusFour,
                focusFive: _focusFive,
                focusSix: _focusSix,
                onPressed: () async {
                  if (_one.text != '' &&
                      _two.text != '' &&
                      _three.text != '' &&
                      _four.text != '' &&
                      _five.text != '' &&
                      _six.text != '') {
                    setState(() {
                      this.isLoading = true;
                    });
                    String smsCode = _one.text +
                        _two.text +
                        _three.text +
                        _four.text +
                        _five.text +
                        _six.text;
                    AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verifyID,
                      smsCode: smsCode,
                    );

                    bool result = await FirebaseModel.getUserAuth(
                        credential, phoneNumber);

                    if (result) {
                      setState(() {
                        this.isLoading = false;
                      });
                      Navigator.of(_).pop();
                      Navigator.of(context).popAndPushNamed('/userRegister');
                    }
                  } else {
                    setState(() {
                      this.isLoading = false;
                    });
                  }
                },
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (timeout) {},
      );
    } catch (e) {
      print(e.toString());
      setState(() {
        this.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
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
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintText: 'cc',
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Constant.kPrimaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Constant.kPrimaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                value: this._codeController.text,
                                items: this._code,
                                onChanged: (value) {
                                  this._codeController.text = value;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                cursorColor: Constant.kPrimaryColor,
                                focusNode: _numberFocus,
                                controller: this._numberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'enter your number...',
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
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ),
                                maxLength: 10,
                                maxLines: 1,
                                onChanged: (value) {},
                                onFieldSubmitted: (value) {
                                  if (_numberController.text.length == 10) {
                                    setState(() {
                                      this.isLoading = true;
                                    });
                                    String phoneNumber =
                                        this._codeController.text +
                                            _numberController.text;
                                    loggingIn(phoneNumber);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  RawMaterialButton(
                    fillColor: Constant.kPrimaryColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      if (_numberController.text.length == 10) {
                        _numberFocus.unfocus();
                        setState(() {
                          this.isLoading = true;
                        });
                        String phoneNumber =
                            this._codeController.text + _numberController.text;
                        loggingIn(phoneNumber);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Let\'s Start',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white, //Constant.kPrimaryColor,
                              fontFamily: 'Haydes',
                              fontSize: 38.0,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            FlutterIcons.angle_right_faw5s,
                            color: Colors.white, //Constant.kPrimaryColor,
                            size: 48,
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
      ),
    );
  }
}
