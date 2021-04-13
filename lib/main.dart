import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Packages.dart';
import 'package:vchat/EXPORTS/Pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _cache = await SharedPreferences.getInstance();

  String defaultRoute = '/';
  try {
    if (_cache.getBool('loggedIn')) {
      defaultRoute = '/home';
      Map<String, dynamic> _data = json.decode(_cache.getString('userData'));

      Constant.superUser.uid = _data['uid'];
      Constant.superUser.contact = _data['contact'];
      Constant.superUser.username = _data['username'];
      Constant.superUser.image = _data['image'];
      Constant.superUser.joinedOn = DateTime.parse(_data['joinedOn']);
    }
  } catch (e) {
    print(e.toString());
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      MyApp(
        defaultRoute: defaultRoute,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String defaultRoute;

  MyApp({this.defaultRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V Chat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Constant.kPrimaryColor,
      ),
      initialRoute: this.defaultRoute,
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => ChatHomeScreen(),
        '/userRegister': (context) => UserRegister(),
      },
    );
  }
}
