import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vchat/Constants.dart';

class OTPSheet extends StatelessWidget {
  final TextEditingController controllerOne;
  final TextEditingController controllerTwo;
  final TextEditingController controllerThree;
  final TextEditingController controllerFour;
  final TextEditingController controllerFive;
  final TextEditingController controllerSix;

  final FocusNode focusOne;
  final FocusNode focusTwo;
  final FocusNode focusThree;
  final FocusNode focusFour;
  final FocusNode focusFive;
  final FocusNode focusSix;

  final Function onPressed;

  const OTPSheet({
    Key key,
    this.controllerOne,
    this.controllerTwo,
    this.controllerThree,
    this.controllerFour,
    this.controllerFive,
    this.controllerSix,
    this.focusOne,
    this.focusTwo,
    this.focusThree,
    this.focusFour,
    this.focusFive,
    this.focusSix,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  textField(controllerOne, focusOne, focusTwo),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  textField(controllerTwo, focusTwo, focusThree),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  textField(controllerThree, focusThree, focusFour),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  textField(controllerFour, focusFour, focusFive),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  textField(controllerFive, focusFive, focusSix),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  textField(controllerSix, focusSix, null),
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
                  onPressed: onPressed,
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
}
