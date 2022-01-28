import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewChat extends StatefulWidget {
  const NewChat({Key? key}) : super(key: key);

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;
  final _chatController = TextEditingController();
  var _enteredMsg = '';

  void _sendChat() {
    _firestore.collection('chat').add({
      'text': _chatController.text,
      'createdAt': Timestamp.now(),
      'userId': _user!.uid,
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              controller: _chatController,
              onChanged: (value) {
                setState(() {
                  _enteredMsg = value;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          _enteredMsg.trim().isEmpty
              ? Container()
              : CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: _sendChat,
                    icon: const Icon(
                      Icons.send_rounded,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
