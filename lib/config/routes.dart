import 'package:flutter/material.dart';

import '../views/chat_page.dart';

const String chatPage = 'chat';

Route<dynamic> controller(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case chatPage:
      return MaterialPageRoute(builder: (context) => ChatPage());
    default:
      throw ('This route doesn\'t exists');
  }
}
