import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  final PageController _pageController = new PageController();
  double _currentPage = 0.0;
  final splashImages = [
    "images/splash_0.jpeg",
    "images/splash_1.jpeg",
    "images/splash_2.jpeg",
  ];

  goToHomePage() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, goToHomePage);
  }

  @override
  void initState() {
    super.initState();
//    countDown();
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: (context, constraints) =>
        new NotificationListener(
            onNotification: (ScrollNotification note) {
              setState(() {
                _currentPage:
                _pageController.page;
              });
            },
            child: PageView.custom(
              physics: const PageScrollPhysics(
                  parent: const ClampingScrollPhysics()),
              controller: _pageController,
              childrenDelegate: new SliverChildBuilderDelegate(
                      (context, index) =>
                  new _SimplePage(
                    index,
                    parallaxOffset:
                    constraints.maxWidth / 2.0 * (index - _currentPage),
                  ),
                  childCount: 3),
            )));
  }
}

class _SimplePage extends StatelessWidget {
  final int data;
  final double parallaxOffset;

  _SimplePage(this.data, {Key key, this.parallaxOffset = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final normalImage = new Image.asset(
      'images/splash_' + this.data.toString() + '.jpeg',
      fit: BoxFit.fill,
    );
    final lastImage = GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
      child: new Image.asset(
        'images/splash_' + this.data.toString() + '.jpeg',
        fit: BoxFit.fill,
      ),
    );
    return data == 2 ? lastImage : normalImage;
  }
}
