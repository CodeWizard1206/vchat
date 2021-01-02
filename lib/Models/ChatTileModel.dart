class ChatTileModel {
  String senderID;
  String profileImage;
  String contactName;
  var msgTime;
  String message;
  int unreadCount;

  ChatTileModel({
    this.senderID,
    this.profileImage,
    this.contactName,
    this.msgTime,
    this.message,
    this.unreadCount,
  });

  ChatTileModel copyWith({
    String senderID,
    String profileImage,
    String contactName,
    var msgTime,
    String message,
    int unreadCount,
  }) {
    return ChatTileModel(
      senderID: senderID ?? this.senderID,
      profileImage: profileImage ?? this.profileImage,
      contactName: contactName ?? this.contactName,
      msgTime: msgTime ?? this.msgTime,
      message: message ?? this.message,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'profileImage': profileImage,
      'contactName': contactName,
      'msgTime': msgTime,
      'message': message,
      'unreadCount': unreadCount,
    };
  }

  factory ChatTileModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatTileModel(
      senderID: map['senderID'],
      profileImage: map['profileImage'],
      contactName: map['contactName'],
      msgTime: map['msgTime'],
      message: map['message'],
      unreadCount: map['unreadCount'],
    );
  }
}
