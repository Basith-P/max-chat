import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Max Chat'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Row(children: const [
                    Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text('Log out'),
                  ]),
                  value: 'logout',
                ),
              ],
              onSelected: (value) {
                if (value == 'logout') _auth.signOut();
              },
            )
          ],
        ),
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
