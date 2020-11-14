import 'package:flutter/material.dart';

class Knowledge001Page extends StatefulWidget {
  final String title;

  Knowledge001Page({Key key, this.title = "padding不同用法、宽高背景gravity"})
      : super(key: key);

  @override
  _Knowledge001PageState createState() => _Knowledge001PageState();
}

class _Knowledge001PageState extends State<Knowledge001Page> {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15.0, // TODO 字体大小
            ),
          ),
          titleSpacing: 0.0, // TODO 与返回按钮间的间距
        ),
        body: Scrollbar(
          // 显示进度条
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topLeft, // TODO 居中
                child: Column(
                  //动态创建一个List<Widget>
                  children: <Widget>[
                    /*SizedBox(
                      width: 10.0,
                    ),*/
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        // TODO 这个是button的父节点的padding
                        child: Text(
                          "1",
                          textScaleFactor: 9.0,
                        )),
                    Text(
                      "2",
                      style: TextStyle(
                        background: Paint()..color = Colors.red, // TODO 背景颜色
                      ),
                      textScaleFactor: 9.0,
                    ),
                    RaisedButton(
                      child: Text("3"),
                      padding: EdgeInsets.all(20.0), // TODO 这个是button里面的padding
                    ),
                    Text(
                      "4",
                      textScaleFactor: 9.0,
                    ),
                    Text(
                      "5",
                      textScaleFactor: 9.0,
                    ),
                    Text(
                      "6",
                      textScaleFactor: 9.0,
                    ),
                    Text(
                      "7",
                      textScaleFactor: 9.0,
                    ),
                    Text(
                      "8",
                      textScaleFactor: 9.0,
                    ),
                  ],
                )),
          ),
        ));
  }
}
