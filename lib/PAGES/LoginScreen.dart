import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/PAGES/UserRegister.dart';

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
    // TextEditingController _otp = TextEditingController();
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
      var _auth = FirebaseAuth.instance;
      _auth.verifyPhoneNumber(
        timeout: const Duration(
          seconds: 120,
        ),
        phoneNumber: phoneNumber,
        verificationCompleted: (credentials) async {
          print(credentials.smsCode);
          String smsCode = credentials.smsCode;
          var _result = await _auth.signInWithCredential(credentials);
          var _user = _result.user;
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
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  this.isLoading = true;
                });

                if (_user != null) {
                  Navigator.of(context).pop();
                  setState(() {
                    this.isLoading = false;
                  });
                  Navigator.of(context).popAndPushNamed('/userRegister');
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
              return Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      maxHeight: (MediaQuery.of(context).size.height / 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_one, _focusOne, _focusTwo),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_two, _focusTwo, _focusThree),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_three, _focusThree, _focusFour),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_four, _focusFour, _focusFive),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_five, _focusFive, _focusSix),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            textField(_six, _focusSix, null),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RawMaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
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
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                  verificationId: verifyID,
                                  smsCode: smsCode,
                                );

                                var _result = await _auth
                                    .signInWithCredential(credential);
                                var _user = _result.user;

                                if (_user != null) {
                                  setState(() {
                                    this.isLoading = false;
                                  });
                                  Navigator.of(_).pop();
                                  Navigator.of(context)
                                      .popAndPushNamed('/userRegister');
                                  // Navigator.of(context)
                                  //     .popAndPushNamed('/infoPost');
                                }
                              } else {
                                setState(() {
                                  this.isLoading = false;
                                });
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Barty',
                                  ),
                                ),
                                // SizedBox(width: 5.0),
                                Icon(
                                  FlutterIcons.angle_right_faw5s,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            fillColor: Constant.kPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
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

  Widget textField(TextEditingController controller, FocusNode currentFocus,
      FocusNode nextFocus) {
    return Expanded(
      flex: 4,
      child: TextFormField(
        cursorColor: Constant.kPrimaryColor,
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        autofocus: false,
        decoration: InputDecoration(
          counterText: '',
          hintText: '',
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constant.kPrimaryColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constant.kPrimaryColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        maxLines: 1,
        maxLength: 1,
        onChanged: (value) {
          if (value != '') {
            if (currentFocus.hasPrimaryFocus) {
              if (nextFocus != null) {
                if (!nextFocus.hasFocus) {
                  nextFocus.requestFocus();
                }
              }
            }
          }
        },
      ),
    );
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
