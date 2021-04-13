import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Packages.dart';

class MessageSenderTile extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  final Function onTap;
  MessageSenderTile({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(
                fontSize: 15.0,
              ),
              cursorColor: Constant.kPrimaryColor,
              controller: this._controller,
              focusNode: _focus,
              decoration: InputDecoration(
                hintText: 'Type something...',
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constant.kPrimaryColor,
                    width: 2,
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
              maxLines: 1,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_focus.hasPrimaryFocus) {
                _focus.unfocus();
              }
              if (_controller.text != '') {
                onTap(_controller);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                FlutterIcons.send_mdi,
                size: 32.0,
                color: Constant.kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
