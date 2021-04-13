import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Packages.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
