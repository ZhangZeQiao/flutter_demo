import 'package:flutter/material.dart';

class Animation004Page extends StatefulWidget {
  final String title;

  Animation004Page({Key key, this.title = "封装一个动画"}) : super(key: key);

  @override
  _Animation004PageState createState() => _Animation004PageState();
}

class _Animation004PageState extends State<Animation004Page>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GrowTransition(
        child: Image.asset("assets/images/icon_switch_open.png"),
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({
    this.child,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
