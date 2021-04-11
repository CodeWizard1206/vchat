import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vchat/Constants.dart';
import 'package:vchat/MODELS/ChatDataModel.dart';
import 'package:vchat/Models/ChatTileModel.dart';
import 'package:vchat/Models/UserModel.dart';

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
          Constant.superUser.joinedOn = userData.data()['joinedOn'].toDate();
        } else {
          Constant.superUser.uid = _user.uid;
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

  static Future<bool> registerUser(
      String username, bool uploadImage, File image) async {
    String imageURL;
    String imageName =
        (Constant.superUser.uid + '.' + (image.path.split('.').last));

    try {
      if (uploadImage) {
        await _storage
            .ref()
            .child('profileImages/' + imageName)
            .putFile(image)
            .onComplete;
        var uri = await _storage
            .ref()
            .child('profileImages/' + imageName)
            .getDownloadURL();
        imageURL = uri.toString();
      }

      Constant.superUser.joinedOn = DateTime.now();

      _firestore.collection('userDatabase').doc(Constant.superUser.uid).set({
        'contact': Constant.superUser.contact,
        'username': username,
        'image': imageURL,
        'joinedOn': Constant.superUser.joinedOn
      });

      Constant.superUser.username = username;
      Constant.superUser.image = imageURL;

      storeCache();

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> updateUser(
      String username, bool uploadImage, File image, bool remove) async {
    String imageURL = Constant.superUser.image;
    String imageName =
        (Constant.superUser.uid + '.' + (image.path.split('.').last));

    try {
      if (uploadImage || (image == null && remove)) {
        //Deleting Previous Image if any
        if (imageURL != null) {
          try {
            await _storage
                .ref()
                .child('profileImages/' + Constant.superUser.uid + '.png')
                .delete();
          } catch (e) {
            print(e);
            try {
              await _storage
                  .ref()
                  .child('profileImages/' + Constant.superUser.uid + '.PNG')
                  .delete();
            } catch (e) {
              print(e);
              try {
                await _storage
                    .ref()
                    .child('profileImages/' + Constant.superUser.uid + '.jpg')
                    .delete();
              } catch (e) {
                print(e);
                try {
                  await _storage
                      .ref()
                      .child('profileImages/' + Constant.superUser.uid + '.JPG')
                      .delete();
                } catch (e) {
                  print(e);
                  try {
                    await _storage
                        .ref()
                        .child(
                            'profileImages/' + Constant.superUser.uid + '.JPEG')
                        .delete();
                  } catch (e) {
                    print(e);
                    try {
                      await _storage
                          .ref()
                          .child('profileImages/' +
                              Constant.superUser.uid +
                              '.jpeg')
                          .delete();
                    } catch (e) {
                      print(e);
                      return false;
                    }
                  }
                }
              }
            }
          }
        }

        //Uploading New Image to Firebase Storage
        if (!remove) {
          await _storage
              .ref()
              .child('profileImages/' + imageName)
              .putFile(image)
              .onComplete;
          var uri = await _storage
              .ref()
              .child('profileImages/' + imageName)
              .getDownloadURL();
          imageURL = uri.toString();
        }
      }

      //Updating User Details on Firebase Database
      _firestore.collection('userDatabase').doc(Constant.superUser.uid).update({
        'username': username,
        'image': imageURL,
      });

      Constant.superUser.username = username;
      Constant.superUser.image = imageURL;

      storeCache();

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<UserModel>> getContactList() async {
    var doc =
        await _firestore.collection('userDatabase').orderBy('username').get();

    List<UserModel> users = doc.docs.map((e) => UserModel.fromDoc(e)).toList();

    return users;
  }

  static Future<void> updateUnread(String uid) async {
    await _firestore
        .collection('userDatabase')
        .doc(Constant.superUser.uid)
        .collection('chats')
        .doc(uid)
        .update({'unread': false});
  }

  static Stream<List<ChatTileModel>> getAllChats() {
    var _data = _firestore
        .collection('userDatabase')
        .doc(Constant.superUser.uid)
        .collection('chats')
        .orderBy('msgTime')
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatTileModel.fromMap(doc)).toList());

    return _data;
  }

  static Stream<List<ChatDataModel>> getChats(String dbName) {
    var _data = _firestore
        .collection(dbName)
        .orderBy('msgTime')
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatDataModel.fromDoc(doc)).toList());

    return _data;
  }

  static Future<void> storeCache() async {
    SharedPreferences _cache = await SharedPreferences.getInstance();

    _cache.setBool('loggedIn', true);
    _cache.setString('userData', json.encode(Constant.superUser.toJSON()));
  }
}
