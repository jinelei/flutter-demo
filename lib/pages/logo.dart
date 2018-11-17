import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoPage extends StatefulWidget {
  final String pageText;

  LogoPage(this.pageText);

  @override
  createState() => new _LogoPageState(this.pageText);
}

class _LogoPageState extends State<LogoPage>
    with SingleTickerProviderStateMixin {
  final String pageText;
  Animation<double> animationDouble;
  Animation<Color> animationColor;
  AnimationController controller;

  _LogoPageState(this.pageText);

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animationColor =
        new ColorTween(begin: Colors.green, end: Colors.red).animate(controller)
          ..addListener(() {
            if (animationColor.isCompleted) controller.reverse();
            setState(() {});
          })
          ..addStatusListener((status) {
            print(status);
            if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    animationDouble = new Tween(begin: 100.0, end: 300.0).animate(controller)
      ..addListener(() {
        if (animationDouble.isCompleted) controller.reverse();
        setState(() {});
      })
      ..addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _animationSwitchStatus() {
    print(controller.isAnimating);
    if (controller.isAnimating) {
      controller.stop();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.pageText, style: new TextStyle(color: animationColor.value),),
      ),
      body: Center(
        child: GestureDetector(
            onTap: _animationSwitchStatus,
            child: new Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
              height: animationDouble.value,
              width: animationDouble.value,
              child: new FlutterLogo(),
            )),
      ),
    );
  }
}
