import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Network001Page extends StatefulWidget {
  final String title;

  Network001Page({Key key, this.title = "通过HttpClient发起HTTP请求"})
      : super(key: key);

  @override
  _Network001Page createState() => _Network001Page();
}

class _Network001Page extends State<Network001Page> {
  bool loading = false;
  String responseBody = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("点击获取百度页面数据"),
            onPressed: () {
              _getHttp();
            },
          ),
          Text(responseBody),
        ],
      ),
    );
  }

  _getHttp() async {
    setState(() {
      loading = true;
      responseBody = "正在请求...";
    });
    try {
      // 使用HttpClient发起请求分为五步：
      // 1、创建一个HttpClient：
      HttpClient httpClient = HttpClient();
      // 2、打开Http连接，设置请求头：
      Uri uri = Uri.parse("https://www.baidu.com/");
      HttpClientRequest httpClientRequest = await httpClient.getUrl(uri);
      /*httpClientRequest.headers.add("user-agent",
          "Mozilla/5.0 (Linux; U; Android 4.0.3; en-us; M9 Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile");*/
      // 3、等待连接服务器：
      HttpClientResponse httpClientResponse = await httpClientRequest.close();
      // 4、读取响应内容：
      responseBody = await httpClientResponse.transform(utf8.decoder).join();
      // 5、请求结束，关闭HttpClient：
      httpClient.close();
    } catch (e) {
      responseBody = "请求失败：$e";
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
