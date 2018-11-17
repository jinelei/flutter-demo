import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String pageText;

  SecondPage(this.pageText);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageText),
      ),
      body: new Center(
        child: new Text('second page'),
      ),
    );
  }
}
