import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataModel {
  String chatId;
  String senderID;
  String msgType;
  String msg;
  String fileURL;
  String fileName;
  DateTime msgDate;

  ChatDataModel({
    this.chatId,
    this.senderID,
    this.msgType,
    this.msg,
    this.fileURL,
    this.fileName,
    this.msgDate,
  });

  ChatDataModel copyWith({
    String chatId,
    String senderID,
    String msgType,
    String msg,
    String fileURL,
    String fileName,
    DateTime msgDate,
  }) {
    return ChatDataModel(
      chatId: chatId ?? this.chatId,
      senderID: senderID ?? this.senderID,
      msgType: msgType ?? this.msgType,
      msg: msg ?? this.msg,
      fileURL: fileURL ?? this.fileURL,
      fileName: fileName ?? this.fileName,
      msgDate: msgDate ?? this.msgDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'msgType': msgType,
      'msg': msg,
      'fileURL': fileURL,
      'fileName': fileName,
      'msgDate': msgDate,
    };
  }

  factory ChatDataModel.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data();

    return ChatDataModel(
      chatId: doc.id,
      senderID: map['senderID'],
      msgType: map['msgType'],
      msg: map['msg'],
      fileURL: map['fileURL'],
      fileName: map['fileName'],
      msgDate: map['msgDate'].toDate(),
    );
  }

  @override
  String toString() {
    return 'ChatDataModel(chatId: $chatId, senderID: $senderID, msgType: $msgType, msg: $msg, fileURL: $fileURL, fileName: $fileName, msgDate: $msgDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatDataModel &&
        other.chatId == chatId &&
        other.senderID == senderID &&
        other.msgType == msgType &&
        other.msg == msg &&
        other.fileURL == fileURL &&
        other.fileName == fileName &&
        other.msgDate == msgDate;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        senderID.hashCode ^
        msgType.hashCode ^
        msg.hashCode ^
        fileURL.hashCode ^
        fileName.hashCode ^
        msgDate.hashCode;
  }
}
