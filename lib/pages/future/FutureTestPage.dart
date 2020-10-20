import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureTestPage extends StatefulWidget {
  FutureTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _FutureTestPageState();
}

class _FutureTestPageState extends State<FutureTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: RaisedButton(
        child: Text('测试'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

}
