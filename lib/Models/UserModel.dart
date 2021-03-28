import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String uid;
  String image;
  String username;
  String contact;
  var joinedOn;

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

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data();

    return UserModel(
      uid: doc.id,
      image: map['image'],
      username: map['username'],
      contact: map['contact'],
      joinedOn: map['joinedOn'],
    );
  }
}
