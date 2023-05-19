import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/message.dart';

class Message_Page extends StatefulWidget {
  const Message_Page({super.key});

  @override
  State<Message_Page> createState() => _Message_PageState();
}

class _Message_PageState extends State<Message_Page> {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;


   String messageTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final time = TimeOfDay.fromDateTime(dateTime).format(context);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No messages available'),
                  );
                }

                final messages = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final msgInfo = data['msgInfo'];
                  final sender = data['sender'];
                  final time = data['timestamp'];

                  return Message(
                      msgInfo: msgInfo, sender: sender, timestamp: time);
                }).toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSender = message.sender ==
                        'Admin'; // Replace 'John Doe' with the dynamic sender information

                    return Align(
                      alignment: //isSender
                           Alignment.centerLeft,
                          //: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isSender ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.sender,
                              style: TextStyle(
                                color: isSender ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              message.msgInfo,
                              style: TextStyle(
                                color: isSender ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              messageTime(message.timestamp),
                              style: TextStyle(
                                color: isSender ? Colors.white70 : Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ])


    );
  }
}