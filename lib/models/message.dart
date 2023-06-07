// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String msgInfo;
  String sender;
  Timestamp timestamp;

  Message({
    required this.msgInfo,
    required this.sender,
    required this.timestamp,
  });

  Message copyWith({
    String? msgInfo,
    String? sender,
  }) {
    return Message(
      msgInfo: msgInfo ?? this.msgInfo,
      sender: sender ?? this.sender,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msgInfo': msgInfo,
      'sender': sender,
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (msgInfo != null) 'msgInfo': msgInfo,
      if (sender != null) 'sender': sender,
      if (timestamp != null) 'timestamp': timestamp,
    };
  }

  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Message(
      msgInfo: data?['msgInfo'] as String,
      sender: data?['sender'] as String,
      timestamp: data?['timestamp'] as Timestamp,
    );
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      msgInfo: map['msgInfo'] as String,
      sender: map['sender'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(msgInfo: $msgInfo, sender: $sender, timestamp: $timestamp )';
  }

  // @override
  // bool operator ==(covariant Message other) {
  //   if (identical(this, other)) return true;

  //   return other.password == password && other.email == email;
  // }

  @override
  int get hashCode {
    return msgInfo.hashCode ^ sender.hashCode ^ timestamp.hashCode;
  }
}
