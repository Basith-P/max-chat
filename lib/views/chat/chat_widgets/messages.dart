import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        final chats = snapshot.data.docs;
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (ctx, i) => Text(
            chats[0]['text'],
          ),
        );
      },
    );
  }
}
