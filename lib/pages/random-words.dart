import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsPage extends StatefulWidget {
  @override
  createState() => new RandomWordsPageState();
}

class RandomWordsPageState extends State<RandomWordsPage>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  _pushSaved() {
    print('pushSaved');
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map(
        (pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('saved suggestions'),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  void _handleTap() {
    print('tap');
  }

  void _handleTapDown(TapDownDetails details) {
    print('tap down ' + details.globalPosition.toString());
  }

  void _handleTapUp(TapUpDetails details) {
    print('tap up ' + details.globalPosition.toString());
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    print('drag start ' + details.globalPosition.toString());
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    print('drag end ' + details.primaryVelocity.toString());
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    print('drag update ' + details.globalPosition.toString());
  }

  void _handleHorizontalDragStart(DragStartDetails details) {
    print('drag start ' + details.globalPosition.toString());
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    print('drag end ' + details.primaryVelocity.toString());
  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    print('drag update ' + details.globalPosition.toString());
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(1));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    void _handleHorizontalDragStart(DragStartDetails details) {
      print('drag row start ' + details.globalPosition.toString());
    }

    void _handleHorizontalDragEnd(DragEndDetails details) {
      print('drag row end ' + details.primaryVelocity.toString());
    }

    void _handleHorizontalDragUpdate(DragUpdateDetails details) {
      print('drag row update ' + details.globalPosition.toString());
    }

    return GestureDetector(
      onHorizontalDragStart: _handleHorizontalDragStart,
      onHorizontalDragEnd: _handleHorizontalDragEnd,
      onHorizontalDragUpdate: _handleHorizontalDragUpdate,
      child: new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? animation.value : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved)
              _saved.remove(pair);
            else
              _saved.add(pair);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation =
        new ColorTween(begin: Colors.grey, end: Colors.red).animate(controller)
          ..addListener(() {
            if (animation.isCompleted) controller.reverse();
            setState(() {});
          })
          ..addStatusListener((status) {
//            print(status);
            if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onVerticalDragStart: _handleVerticalDragStart,
      onVerticalDragEnd: _handleVerticalDragEnd,
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onHorizontalDragStart: _handleHorizontalDragStart,
      onHorizontalDragEnd: _handleHorizontalDragEnd,
      onHorizontalDragUpdate: _handleHorizontalDragUpdate,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildSuggestions(),
      ),
    );
  }
}
