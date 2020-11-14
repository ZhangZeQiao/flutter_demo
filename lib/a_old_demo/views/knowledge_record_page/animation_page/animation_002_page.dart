import 'package:flutter/material.dart';

class Animation002Page extends StatefulWidget {
  final String title;

  Animation002Page({Key key, this.title = "用AnimatedWidget从动画中分离出widget"})
      : super(key: key);

  @override
  _Animation002PageState createState() => _Animation002PageState();
}

class _Animation002PageState extends State<Animation002Page>
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
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedImage(
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

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  /* TODO AnimatedWidget已添加监听+setState
  * AnimatedWidget
  *
  * widget.listenable.addListener(_handleChange);
  *
  *  void _handleChange() {
  *    setState(() {
  *      // The listenable's state is our build state, and it changed already.
  *    });
  *  }
  * */

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "assets/images/icon_switch_open.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}
