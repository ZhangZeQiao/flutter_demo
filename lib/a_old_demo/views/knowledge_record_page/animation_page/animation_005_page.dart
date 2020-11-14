import 'package:flutter/material.dart';

class Animation005Page extends StatefulWidget {
  final String title;

  Animation005Page({Key key, this.title = "动画状态监听"}) : super(key: key);

  @override
  _Animation005PageState createState() => _Animation005PageState();
}

class _Animation005PageState extends State<Animation005Page>
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

    // TODO 动画状态监听
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }

      /*枚举值	    含义
      dismissed	  动画在起始点停止
      forward	    动画正在正向执行
      reverse	    动画正在反向执行
      completed	  动画在终点停止*/
    });
    animation.addListener(() {
      // 点击监听
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        child: Image.asset("assets/images/icon_switch_open.png"),
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Center(
            child: Container(
              child: child,
              height: animation.value,
              width: animation.value,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
