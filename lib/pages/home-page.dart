import 'package:flutter/material.dart';
import './other-page.dart';
import './second-page.dart';
import './random-words.dart';
import './logo.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var _searchQuery;

  Widget _buildSearchBar() {
    return new AppBar(
      leading: BackButton(
        color: Theme.of(context).accentColor,
      ),
      title: TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'search key'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('main page'),
        flexibleSpace: new Icon(Icons.search),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new LogoPage('from search')));
              }),
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: new ListTile(
                      title: new Text('add'),
                      trailing: new Icon(Icons.add),
                    ),
                    value: '这是增加',
                  ),
                  PopupMenuItem(
                    child: new ListTile(
                      title: new Text('delete'),
                      trailing: new Icon(Icons.delete),
                    ),
                    value: '这是增加',
                  ),
                  PopupMenuItem(
                    child: new ListTile(
                      title: new Text('change'),
                      trailing: new Icon(Icons.update),
                    ),
                    value: '这是删除',
                  ),
                ],
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
                title: new Text('Random Word'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new RandomWordsPage()));
                }),
            new ListTile(
                title: new Text('Logo Page'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new LogoPage('logo page')));
                }),
          ],
        ),
      ),
      body: new Center(
          child: new ListTile(
        title: new Text(
          'home page content',
          style: new TextStyle(fontSize: 32.0),
        ),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new SecondPage(('asdf'))));
        },
      )),
    );
  }
}
