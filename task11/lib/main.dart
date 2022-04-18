import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task11/providers/provider.dart';

import 'screens/listScreen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    );
  }
}
