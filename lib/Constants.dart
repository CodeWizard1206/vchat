import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Models.dart';

class Constant {
  static const kPrimaryColor = Color(0xFF76BCFF); //Color(0xFF2196F3);
  static const kPrimaryDarkColor = Color(0xFF373435);
  static final kComponentBgColor = Colors.grey[200];
  static final UserModel superUser = UserModel(
    contact: '',
    image: null,
    username: '',
    joinedOn: DateTime.now(),
  );
}
