import 'package:chat_app/app/app.dart';
import 'package:chat_app/chat/view/home_screen.dart';
import 'package:chat_app/login/login.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
