import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final chats = snapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chats.length,
            itemBuilder: (ctx, i) => ChatBubble(
              chats[i]['text'],
              chats[i]['username'],
              chats[i]['userId'] == _user!.uid,
              key: ValueKey(chats[i].id),
            ),
          );
        },
      ),
    );
  }
}
