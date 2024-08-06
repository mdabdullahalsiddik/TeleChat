// To parse this JSON data, do
//
//     final messagesModel = messagesModelFromJson(jsonString);

import 'dart:convert';

List<MessagesModel> messagesModelFromJson(String str) => List<MessagesModel>.from(json.decode(str).map((x) => MessagesModel.fromJson(x)));

String messagesModelToJson(List<MessagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessagesModel {
    int? id;
    int? senderId;
    int? receiverId;
    String? message;
    String? type;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? isMe;

    MessagesModel({
        this.id,
        this.senderId,
        this.receiverId,
        this.message,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.isMe,
    });

    factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isMe: json["is_me"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_me": isMe,
    };
}
