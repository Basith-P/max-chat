import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../views/chat/chat_page.dart';
import '../views/auth/auth_page.dart';

const String chatPage = 'chat';
const String authPage = 'auth';
const String initialPage = 'initial';

Route<dynamic> controller(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case initialPage:
      Widget initialPage = StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) return ChatPage();
          return const AuthPage();
        },
      );
      return MaterialPageRoute(builder: (context) => initialPage);
    case authPage:
      return MaterialPageRoute(builder: (context) => const AuthPage());
    case chatPage:
      return MaterialPageRoute(builder: (context) => ChatPage());
    default:
      throw ('This route doesn\'t exists');
  }
}
