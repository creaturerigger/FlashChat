import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder(
      {Key? key, required this.firestoreInstance, required this.loggedInUser})
      : super(key: key);

  final FirebaseFirestore firestoreInstance;
  final User? loggedInUser;

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
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('message');
          final messageSender = message.get('sender');
          final currentUser = loggedInUser!.email;
          if (currentUser == messageSender) {}
          final messageWidget = MessageBubble(
            sender: messageSender,
            message: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.all(10.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
