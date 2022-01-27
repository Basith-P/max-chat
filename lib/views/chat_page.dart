import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: _fireStore.collection('chats/KG3soCfN1MgUQ7wP9PhP/messages').snapshots(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data.docs;
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (ctx, i) => ListTile(
                      title: Text(docs[i]['text']),
                    ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_rounded),
          onPressed: () {},
        ));
  }
}
