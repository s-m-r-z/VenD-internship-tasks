import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Key is used to identify a widget/card/list tile

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Suggested Names of Startup',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final suggestion = <WordPair>[];
  static const textStyle = TextStyle(fontSize: 18.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(("Random Names of Startup")),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return const Divider();
          }

          final listHalfLength = index ~/ 2;

          if (listHalfLength >= suggestion.length) {
            suggestion.addAll(generateWordPairs().take(20));
          }

          return ListTile(
            title: Text(
              suggestion[listHalfLength].asPascalCase,
              style: textStyle,
            ),
          );
        },
      ),
    );
  }
}
