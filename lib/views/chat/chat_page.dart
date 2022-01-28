import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_widgets/messages.dart';

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
        body: Column(
          children: const [
            Expanded(child: Messages()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_rounded),
          onPressed: () {},
        ));
  }
}
