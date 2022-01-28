import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.msg, this.uname, this.isMe, {Key? key}) : super(key: key);

  final String msg;
  final bool isMe;
  final String uname;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? _theme.colorScheme.secondary.withAlpha(150) : Colors.blueGrey[100],
            borderRadius: isMe
                ? BorderRadius.circular(12).copyWith(bottomRight: const Radius.circular(0))
                : BorderRadius.circular(12).copyWith(topLeft: const Radius.circular(0)),
          ),
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  uname,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isMe) const SizedBox(height: 4),
              Text(
                msg,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
