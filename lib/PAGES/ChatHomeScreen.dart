import 'package:vchat/EXPORTS/Components.dart';
import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Models.dart';
import 'package:vchat/EXPORTS/Packages.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamProvider<List<ChatTileModel>>(
            create: (_) => FirebaseModel.getAllChats(),
            child: ChatHome(),
          ),
        ),
      ),
    );
  }
}

class ChatHome extends StatefulWidget {
  ChatHome({Key key}) : super(key: key);

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool isLoading = false;

  Future<void> newChat(BuildContext context) async {
    var permission = await Permission.contacts.request().isGranted;

    if (permission) {
      setState(() {
        isLoading = true;
      });
      List<UserModel> _users = await FirebaseModel.getContactList();
      List<String> contact = [];
      List<Map<String, dynamic>> nonUsers = [];
      Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);

      _users = _users
          .where((element) => element.uid != Constant.superUser.uid)
          .toList();

      for (Contact c in contacts) {
        Iterable<Item> phone = c.phones;

        for (Item i in phone) {
          String num = i.value.replaceAll('-', '').replaceAll(' ', '');
          if (num.length >= 10) {
            num = num.substring((num.length - 10), num.length);
            contact.add(num);
            Map<String, dynamic> map = {
              'name': c.displayName,
              'contact': num,
            };
            nonUsers.add(map);
          }
        }
      }

      contact = contact.toSet().toList();

      _users = _users.where((user) {
        String con = user.contact;
        con = con.substring((con.length - 10), con.length);

        if (contact.contains(con)) {
          contact.remove(con);
          return true;
        } else {
          return false;
        }
      }).toList();

      nonUsers = nonUsers.toSet().toList();

      nonUsers = nonUsers
          .where((element) => contact.contains(element['contact']))
          .toList();

      List<dynamic> _userList = _users
          .map((user) => Container(child: ExistingUserTile(user: user)))
          .toList();

      _userList.addAll(nonUsers
          .map((non) => Container(child: NonUserTile(user: non)))
          .toList());

      setState(() {
        isLoading = false;
      });

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (_) => AddChatPop(userList: _userList),
      );
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Permission request denied!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var _chats = Provider.of<List<ChatTileModel>>(context);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15.0,
              bottom: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                Material(
                  color: Constant.kComponentBgColor,
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Icon(
                        FlutterIcons.search_faw5s,
                        color: Constant.kPrimaryColor,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Material(
                  color: Constant.kComponentBgColor,
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                      newChat(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Icon(
                        FlutterIcons.plus_faw5s,
                        color: Constant.kPrimaryColor,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: Constant.superUser.image != null
                          ? NetworkImage(Constant.superUser.image)
                          : AssetImage('assets/images/user.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _chats == null
                ? Center(
                    child: LoaderWidget(),
                  )
                : _chats.length == 0
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icon.png',
                              width: (MediaQuery.of(context).size.width * 0.75),
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontFamily: 'Haydes',
                                fontSize: 62.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children:
                            _chats.map((chat) => ChatTile(data: chat)).toList(),
                      ),
          ),
        ],
      ),
    );
  }
}
