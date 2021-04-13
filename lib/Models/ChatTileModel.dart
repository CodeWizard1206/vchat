import 'package:vchat/EXPORTS/Packages.dart';

class ChatTileModel {
  String uid;
  String contact;
  String profileImage;
  String contactName;
  DateTime msgTime;
  String message;
  bool unread;

  ChatTileModel({
    this.uid,
    this.contact,
    this.profileImage,
    this.contactName,
    this.msgTime,
    this.message,
    this.unread,
  });

  ChatTileModel copyWith({
    String uid,
    String contact,
    String profileImage,
    String contactName,
    var msgTime,
    String message,
    bool unread,
  }) {
    return ChatTileModel(
      uid: uid ?? this.uid,
      contact: contact ?? this.contact,
      profileImage: profileImage ?? this.profileImage,
      contactName: contactName ?? this.contactName,
      msgTime: msgTime ?? this.msgTime,
      message: message ?? this.message,
      unread: unread ?? this.unread,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contact': contact,
      'profileImage': profileImage,
      'contactName': contactName,
      'msgTime': msgTime,
      'message': message,
      'unread': unread,
    };
  }

  factory ChatTileModel.fromMap(DocumentSnapshot doc) {
    if (doc == null) return null;

    Map<String, dynamic> map = doc.data();

    return ChatTileModel(
      uid: doc.id,
      contact: map['contact'],
      profileImage: map['profileImage'],
      contactName: map['contactName'],
      msgTime: map['msgTime'].toDate(),
      message: map['message'],
      unread: map['unread'],
    );
  }
}
