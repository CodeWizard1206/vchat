import 'package:vchat/EXPORTS/Flutter.dart';
import 'package:vchat/EXPORTS/Packages.dart';

class UserModel {
  String uid;
  String image;
  String username;
  String contact;
  DateTime joinedOn;

  UserModel({
    this.uid,
    @required this.image,
    @required this.username,
    @required this.contact,
    @required this.joinedOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'username': username,
      'contact': contact,
      'joinedOn': joinedOn,
    };
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'image': image,
      'username': username,
      'contact': contact,
      'joinedOn': DateFormat('yyyy-MM-dd hh:mm:ss').format(joinedOn),
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data();

    return UserModel(
      uid: doc.id,
      image: map['image'],
      username: map['username'],
      contact: map['contact'],
      joinedOn: map['joinedOn'].toDate(),
    );
  }
}
