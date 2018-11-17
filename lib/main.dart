// Step 4: Create an infinite scrolling lazily loaded list

import 'package:flutter/material.dart';
import './pages/home-page.dart';
import './pages/splash-page.dart';
import './pages/other-page.dart';
import './pages/second-page.dart';
import './pages/random-words.dart';

void main() => runApp(MyApp());

MaterialApp MyApp() {
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (context) => new HomePage(),
    '/splash': (context) => new SplashPage(),
    '/other': (context) => new OtherPage('other'),
    '/second': (context) => new SecondPage('second'),
    '/random': (context) => new RandomWordsPage(),
  };

  return new MaterialApp(
    routes: _routes,
    initialRoute: '/splash',
  );
}
