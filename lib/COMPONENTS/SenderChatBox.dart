import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Models.dart';
import 'package:vchat/EXPORTS/Packages.dart';

class SenderChatBox extends StatelessWidget {
  final ChatDataModel chat;
  final String uniqueKey;
  const SenderChatBox({Key key, this.chat, this.uniqueKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 7.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(3.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            color: Constant.kPrimaryColor,
            elevation: 5.0,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 50.0,
              ),
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              child: Text(
                dynamicDecrypt(uniqueKey, chat.msg),
                softWrap: true,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
