import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoComponent extends StatefulWidget {
  @override
  createState() => new _LogoComponentState();
}

class _LogoComponentState extends State<LogoComponent>
    with SingleTickerProviderStateMixin {
  Animation<double> animationDouble;
  Animation<Color> animationColor;
  AnimationController controller;

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: _animationSwitchStatus,
          child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: animationDouble.value,
            width: animationDouble.value,
            child: new FlutterLogo(),
          )),
    );
  }

  _animationSwitchStatus() {
    print(controller.isAnimating);
    if (controller.isAnimating) {
      controller.stop();
    } else {
      controller.forward();
    }
  }
}
