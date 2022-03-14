import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/message_bubble.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key, required this.firestoreInstance})
      : super(key: key);

  final FirebaseFirestore firestoreInstance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreInstance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('message');
          final messageSender = message.get('sender');
          final messageWidget =
              MessageBubble(sender: messageSender, message: messageText);
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
