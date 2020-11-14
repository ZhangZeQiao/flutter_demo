import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AFunction002Page extends StatefulWidget {
  final String title;

  AFunction002Page({Key key, this.title = "获取电池电量"}) : super(key: key);

  @override
  _AFunction002PageState createState() => _AFunction002PageState();
}

class _AFunction002PageState extends State<AFunction002Page> {
  // TODO 通道的客户端和宿主通过通道构造函数中传递的通道名称进行连接。单个应用中使用的所有通道名称必须是唯一的。
  static const platform = const MethodChannel("samples.flutter.io/battery");
  String _batteryLevel = "Unknow battery level.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Get battery level."),
            onPressed: () {
              _getBatteryLevel();
            },
          ),
          Text(_batteryLevel),
        ],
      ),
    );
  }

  _getBatteryLevel() async {
    String batteryLevel;
    final int result = await platform.invokeMethod("getBatteryLevel");
    batteryLevel = "Battery level at $result%.";
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
