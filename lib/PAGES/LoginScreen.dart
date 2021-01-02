import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vchat/Constants.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 62.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Constant.kPrimaryColor,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'login with mobile number...',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'cc',
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
                          flex: 4,
                          child: TextFormField(
                            controller: this._numberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'enter your number...',
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 50.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                              color: Constant.kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            color: Constant.kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                              color: Constant.kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Material(
                            color: Constant.kComponentBgColor,
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              padding: const EdgeInsets.all(
                                12.0,
                              ),
                              child: Icon(
                                FlutterIcons.google_faw5d,
                                color: Constant.kPrimaryColor,
                                size: 38.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
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
                                FlutterIcons.facebook_faw5d,
                                color: Constant.kPrimaryColor,
                                size: 38.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_numberController.text.length == 10) {
                      setState(() {
                        this.isLoading = true;
                      });
                      String phoneNumber =
                          this._codeController.text + _numberController.text;
                      loggingIn(phoneNumber);
                    }
                  },
                  child: Icon(
                    FlutterIcons.angle_right_faw5s,
                    color: Colors.white,
                    size: 38,
                  ),
                  backgroundColor: Constant.kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loggingIn(String phoneNumber) async {
    // TextEditingController _otp = TextEditingController();
    TextEditingController _one = TextEditingController();
    TextEditingController _two = TextEditingController();
    TextEditingController _three = TextEditingController();
    TextEditingController _four = TextEditingController();
    TextEditingController _five = TextEditingController();
    TextEditingController _six = TextEditingController();
    try {
      await Firebase.initializeApp();
      var _auth = FirebaseAuth.instance;
      _auth.verifyPhoneNumber(
        timeout: const Duration(
          seconds: 120,
        ),
        phoneNumber: phoneNumber,
        verificationCompleted: (credentials) async {
          print(credentials.smsCode);
          String smsCode = credentials.smsCode;
          _one.text = smsCode.substring(0, 1);
          _two.text = smsCode.substring(1, 2);
          _three.text = smsCode.substring(2, 3);
          _four.text = smsCode.substring(3, 4);
          _five.text = smsCode.substring(4, 5);
          _six.text = smsCode.substring(5, 6);
          setState(() {
            this.isLoading = true;
          });

          var _result = await _auth.signInWithCredential(credentials);
          var _user = _result.user;

          if (_user != null) {
            Navigator.of(context).pop();
            setState(() {
              this.isLoading = false;
            });
            Navigator.of(context).popAndPushNamed('/home');
          }
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
            builder: (context) {
              return Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AnimatedPadding(
                          duration: Duration(
                            milliseconds: 150,
                          ),
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom !=
                                    0
                                ? MediaQuery.of(context).viewInsets.bottom - 45
                                : 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              textField(_one),
                              textField(_two),
                              textField(_three),
                              textField(_four),
                              textField(_five),
                              textField(_six),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () async {
                              setState(() {
                                this.isLoading = true;
                              });
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verifyID,
                                smsCode: '',
                              );

                              var _result =
                                  await _auth.signInWithCredential(credential);
                              var _user = _result.user;

                              if (_user != null) {
                                Navigator.of(context).pop();
                                Navigator.of(context).popAndPushNamed('/home');
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'VERIFY',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Constant.kPrimaryColor,
                                  ),
                                ),
                                Icon(
                                  FlutterIcons.angle_right_faw5s,
                                  color: Constant.kPrimaryColor,
                                ),
                              ],
                            ),
                            color: Colors.transparent,
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
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => AlertDialog(
          //     title: Text('enter the otp...'),
          //     content: Container(
          //       width: (MediaQuery.of(context).size.width - 120),
          //       child: Row(
          //         children: [
          //         ],
          //       ),
          //     ),
          //     actions: [
          //       FlatButton(
          //         onPressed: () async {
          //           final String code = _otp.text.trim();
          //           print(code);
          //           print(verifyID);
          // AuthCredential credential = PhoneAuthProvider.credential(
          //   verificationId: verifyID,
          //   smsCode: code,
          // );

          // var _result = await _auth.signInWithCredential(credential);
          // var _user = _result.user;

          // if (_user != null) {
          //   Navigator.of(context).pop();
          //   Navigator.of(context).popAndPushNamed('/home');
          // }
          //         },
          //         color: Constant.kPrimaryColor,
          //         child: Text(
          //           'submit...',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 26.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        },
        codeAutoRetrievalTimeout: (timeout) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Widget textField(TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            autofocus: true,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'enter your otp...',
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.kPrimaryColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.kPrimaryColor,
                  width: 2,
                ),
              ),
            ),
            maxLines: 1,
            maxLength: 1,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
