import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vchat/Constants.dart';

class FirebaseModel {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> getUserAuth(
      PhoneAuthCredential credentials, String contact) async {
    try {
      UserCredential _result = await _auth.signInWithCredential(credentials);
      User _user = _result.user;

      if (_user != null) {
        DocumentSnapshot userData =
            await _firestore.collection('userDatabase').doc(_user.uid).get();

        if (userData.data() != null) {
          Constant.superUser.uid = _user.uid;
          Constant.superUser.contact = userData.data()['contact'];
          Constant.superUser.username = userData.data()['username'];
          Constant.superUser.image = userData.data()['image'];
          Constant.superUser.joinedOn = userData.data()['joinedOn'];
        } else {
          Constant.superUser.contact = contact;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error :' + e.toString());
      return false;
    }
  }
}
