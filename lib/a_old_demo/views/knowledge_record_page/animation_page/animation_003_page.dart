import 'package:flutter/material.dart';

class Animation003Page extends StatefulWidget {
  final String title;

  Animation003Page({Key key, this.title = "用AnimatedBuilder将渲染逻辑分离出来"})
      : super(key: key);

  @override
  _Animation003PageState createState() => _Animation003PageState();
}

/*  用AnimatedWidget可以从动画中分离出widget，而动画的渲染过程（即设置宽高）仍然在AnimatedWidget中，
 *  假设如果我们再添加一个widget透明度变化的动画，那么我们需要再实现一个AnimatedWidget，这样不是很优雅，
 *  如果我们能把渲染过程也抽象出来，那就会好很多，
 *  而AnimatedBuilder正是将渲染逻辑分离出来, (Animation002Page中)上面的build方法中的代码可以改为：
 * */

class _Animation003PageState extends State<Animation003Page>
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
      // body: AnimatedImage(animation: animation,),
      body: AnimatedBuilder(
        animation: animation,
        child: Image.asset(
          "assets/images/icon_switch_open.png",
        ),
        builder: (BuildContext context, Widget child) {
          // TODO AnimatedBuilder返回的对象插入到widget树中
          return Center(
            child: Container(
              height: animation.value,
              width: animation.value,
              // TODO 这个chile是上面的 child: Image.asset("assets/images/icon_switch_open.png",),
              child: child,
            ),
          );
        },
      ),
    );
  }

  /*  上面的代码中有一个迷惑的问题是，child看起来像被指定了两次。
   *  但实际发生的事情是：将外部引用child传递给AnimatedBuilder后AnimatedBuilder再将其传递给匿名构造器， 然后将该对象用作其子对象。
   *  最终的结果是AnimatedBuilder返回的对象插入到widget树中。
   *  也许你会说这和我们刚开始的示例差不了多少，其实它会带来三个好处：
   *  TODO （内置监听setState） 1、不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。
   *  TODO （只刷新动画本身） 2、动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；
   *  而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
   *  TODO （封装） 3、通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
   * */

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
