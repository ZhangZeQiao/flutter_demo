import 'package:flutter/material.dart';

class FunctionalWidget001Page extends StatefulWidget {
  final String title;

  FunctionalWidget001Page({Key key, this.title = "数据共享（InheritedWidget）"})
      : super(key: key);

  @override
  _FunctionalWidget001PageState createState() =>
      _FunctionalWidget001PageState();
}

class _FunctionalWidget001PageState extends State<FunctionalWidget001Page> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        // 使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(), // 子widget中依赖ShareDataWidget
            ),
            RaisedButton(
              child: Text("Increment"),
              // 每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO 使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TODO 父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    // TODO 如果build中没有依赖InheritedWidget，则此回调不会被调用。
  }
}

class ShareDataWidget extends InheritedWidget {
  // 本示例主要是为了演示InheritedWidget的功能特性，并不是计数器的推荐实现方式。
  final int data; // 需要在子树中共享的数据，保存点击次数

  ShareDataWidget({
    @required this.data,
    Widget child,
  }) : super(child: child);

  // 定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    // return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 如果返回true，则子树中依赖(build函数中有调用)本widget的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}
