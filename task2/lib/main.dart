import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Names',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
        primarySwatch: Colors.blue,
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];

  final fontSize = const TextStyle(fontSize: 18.0);
  final saved = <WordPair>{};

  pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: fontSize,
                ),
              );
            },
          );
          final division = tiles.isNotEmpty
              ? ListTile.divideTiles(tiles: tiles, context: context).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: division),
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: fontSize,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ("Random Names of Startup"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: pushSaved,
            tooltip: 'Saved',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider();
          }

          final index = i ~/ 2;

          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(20));
          }
          return _buildRow(suggestions[index]);
        },
      ),
    );
  }
}
