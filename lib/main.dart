import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome to flutter",
      home: RandomWords(),
    );
  }

  void pushNamed() {}
}

class RandomWords extends StatefulWidget {
  RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // ? Var in this class
  final wordPair = WordPair.random();
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerText = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    // ? _pushNAmed

    _pushNamed() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        final tile = _saved.map(((WordPair wordPair) {
          return ListTile(
            title: Text(
              wordPair.asPascalCase,
              style: _biggerText,
            ),
          );
        }));

        final divided = tile.isNotEmpty
            ? ListTile.divideTiles(context: context, tiles: tile).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: Text("Saved Suggestion"),
          ),
          body: ListView(
            children: divided,
          ),
        );
      }));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("StartUp namer App"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(CupertinoIcons.square_favorites),
                onPressed: _pushNamed)
          ],
        ),
        body: Center(child: _buildSuggestion()));
  }

  // ! Build Suggestion
  Widget _buildSuggestion() => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          if (index.isOdd) {
            /// [if number is odd] then return `Divider`
            return Divider();
          }
          final int i = index ~/ 2;
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _builRow(_suggestions[i]);
        },
      );

  Widget _builRow(WordPair suggestion) {
    final _alreadySaved = _saved.contains(suggestion);
    return ListTile(
      onLongPress: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(suggestion);
          } else
            _saved.add(suggestion);
        });
      },
      title: Text(
        suggestion.asPascalCase,
        style: _biggerText,
      ),
      trailing: IconButton(
        icon: Icon(
          _alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: _alreadySaved ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            if (_alreadySaved) {
              _saved.remove(suggestion);
            } else
              _saved.add(suggestion);
          });
        },
      ),
    );
  }
}
