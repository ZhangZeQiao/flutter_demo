import 'package:flutter/material.dart';

class Animation001Page extends StatefulWidget {
  final String title;

  Animation001Page({Key key, this.title = "匀速动画和非匀速动画"}) : super(key: key);

  @override
  _Animation001PageState createState() => _Animation001PageState();
}

/// TODO 需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin
class _Animation001PageState extends State<Animation001Page>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    /// TODO 方式一 匀速动画
    /*controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    // 启动动画(正向执行)
    controller.forward();*/

    /// TODO 方式二 非匀速动画
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // 使用弹性曲线
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceIn,
    );

    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    // 启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Image.asset(
        "assets/images/icon_switch_open.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }

  @override
  void dispose() {
    // TODO 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
