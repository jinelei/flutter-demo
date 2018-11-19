// Step 4: Create an infinite scrolling lazily loaded list

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './pages/home.dart';
import './pages/splash.dart';
import 'package:jinelei/component/book.dart';
import 'package:jinelei/component/moive.dart';
import 'package:jinelei/component/random-words.dart';

var globalSetting;

void main() {
  debugPaintSizeEnabled = !true;
  globalSetting = {
    'test': true,
    'username': 'jinelei',
  };
  return runApp(MyApp());
}

MaterialApp MyApp() {
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (context) => new HomePage(),
    '/splash': (context) => new SplashPage(),
    '/random': (context) => new RandomWordsPage(),
  };

  return new MaterialApp(
    routes: _routes,
    initialRoute: '/',
  );
}
