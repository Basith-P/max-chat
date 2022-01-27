import 'package:flutter/material.dart';

import '../views/chat_page.dart';
import '../auth/auth_page.dart';

const String chatPage = 'chat';
const String authPage = 'auth';

Route<dynamic> controller(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => const AuthPage());
    case chatPage:
      return MaterialPageRoute(builder: (context) => ChatPage());
    default:
      throw ('This route doesn\'t exists');
  }
}
