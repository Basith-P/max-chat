import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewChat extends StatefulWidget {
  const NewChat({Key? key}) : super(key: key);

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  final _firestore = FirebaseFirestore.instance;
  final _chatController = TextEditingController();
  var _enteredMsg = '';

  void _sendChat() {
    _firestore.collection('chat').add({
      'text': _chatController.text,
      'createdAt': Timestamp.now(),
    });
    setState(() {
      _enteredMsg = '';
    });
    _chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type something...',
                fillColor: Colors.pink[50],
                filled: true,
                border: InputBorder.none,
              ),
              controller: _chatController,
              onChanged: (value) {
                setState(() {
                  _enteredMsg = value;
                });
              },
            ),
          ),
          _enteredMsg.trim().isEmpty
              ? Container()
              : IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _sendChat,
                  icon: Icon(
                    Icons.send_rounded,
                  ),
                ),
        ],
      ),
    );
  }
}
