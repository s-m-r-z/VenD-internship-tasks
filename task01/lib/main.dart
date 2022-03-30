
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final word = WordPair.random();
    return const MaterialApp(

      title: 'Suggested Names of Startup',
      home: RandomWords(),

    );
  }

}





class RandomWords extends StatefulWidget{
  const RandomWords({Key?key}):super(key: key);

  @override
  _RandomWordsState createState()=>_RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>
{
  @override
  final sugg=<WordPair>[];

  final font=const TextStyle(fontSize: 18.0);
  final s=<WordPair>{};
  Widget build(BuildContext context)
  {

    return Scaffold(

      appBar: AppBar(
        title:  const Text(("Random Names of Startup")
        ),

      ),
      body: ListView.builder(padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i) {
        if(i.isOdd)
          {
            return const Divider();
          }

        final index= i ~/2;

        if(index>=sugg.length)
          {
            sugg.addAll(generateWordPairs().take(20));
          }
        return ListTile(
          title: Text(
          sugg[index].asPascalCase,
          style:font,
          ),
        );


      },

      ),

    );
  }

}