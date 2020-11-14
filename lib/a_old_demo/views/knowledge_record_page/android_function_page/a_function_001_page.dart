import 'package:flutter/material.dart';

class AFunction001Page extends StatefulWidget {
  final String title;

  AFunction001Page({Key key, this.title = "通知栏（Notification）"})
      : super(key: key);

  @override
  _AFunction001PageState createState() => _AFunction001PageState();
}

class _AFunction001PageState extends State<AFunction001Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("---"),
    );
  }
}
