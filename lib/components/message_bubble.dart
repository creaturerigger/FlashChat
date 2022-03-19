import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.message,
      required this.isMe})
      : super(key: key);

  final String message;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          Material(
            color: isMe ? Colors.white : Colors.lightBlueAccent,
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: isMe
                  ? const Radius.circular(0.0)
                  : const Radius.circular(30.0),
              topRight: isMe
                  ? const Radius.circular(30.0)
                  : const Radius.circular(0.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 12.0,
                  color: isMe ? Colors.black54 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
