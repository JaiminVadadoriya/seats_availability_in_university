import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String messageTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final time = TimeOfDay.fromDateTime(dateTime).format(context);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text('No messages available'),
              );
            }
            // if (snapshot.connectionState == ConnectionState.done) {
            //   return const Center(
            //     child: Text('No messages available'),
            //   );
            // }

            final messages = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Message.fromMap(data);
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isSender
                          ? Theme.of(context).focusColor
                          : Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: const TextStyle(
                            // color: isSender ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          message.msgInfo,
                          style: const TextStyle(
                              // color: isSender ? Colors.white : Colors.black,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          messageTime(message.timestamp),
                          style: const TextStyle(
                            // color: isSender ? Colors.white70 : Colors.grey,
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
    ]));
  }
}
