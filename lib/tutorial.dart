import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// use to understand dart/flutter a little bit better ...

void main() => runApp(MyApp());

final appBar = AppBar(title: Text('Welcome to FLUTS 2 OKAY'));
final wordPair = WordPair.random();

const appTitle = "Welcome to THE Flutter";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator 2',
        home: RandomWords(),
        theme: ThemeData(primaryColor: Colors.red)
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions());
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (BuildContext context) {
          final tiles = _saved.map((WordPair pair) {
            return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
          });
          final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();
          return Scaffold(
            appBar: AppBar(title: Text("Saved Suggestions")),
            body: ListView(children: divided),
          );
        })
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    final borderToUse = alreadySaved ? Icons.favorite : Icons.favorite_border;

    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(borderToUse, color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

final body = Center(child: RandomWords());
