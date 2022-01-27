import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/routes.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaxChat());
}

class MaxChat extends StatelessWidget {
  const MaxChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Max Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: route.controller,
      initialRoute: route.chatPage,
    );
  }
}
