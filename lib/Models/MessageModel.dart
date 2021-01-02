class MessageModel {
  String docId;
  String senderID;
  String message;
  String msgType;
  var msgTime;
  var data;

  MessageModel({
    this.docId,
    this.senderID,
    this.message,
    this.msgType,
    this.msgTime,
    this.data,
  });

  MessageModel copyWith({
    String docId,
    String senderID,
    String message,
    String msgType,
    var msgTime,
    var data,
  }) {
    return MessageModel(
      docId: docId ?? this.docId,
      senderID: senderID ?? this.senderID,
      message: message ?? this.message,
      msgType: msgType ?? this.msgType,
      msgTime: msgTime ?? this.msgTime,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'senderID': senderID,
      'message': message,
      'msgType': msgType,
      'msgTime': msgTime,
      'data': data,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MessageModel(
      docId: map['docId'],
      senderID: map['senderID'],
      message: map['message'],
      msgType: map['msgType'],
      msgTime: map['msgTime'],
      data: map['data'],
    );
  }
}
