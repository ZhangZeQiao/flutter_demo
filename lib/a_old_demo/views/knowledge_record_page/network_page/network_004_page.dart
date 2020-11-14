import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/model/test/flutterchina_repos.dart';

class Network004Page extends StatefulWidget {
  final String title;

  Network004Page({Key key, this.title = "Json解析"}) : super(key: key);

  @override
  _Network004PageState createState() => _Network004PageState();
}

class _Network004PageState extends State<Network004Page> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(),
          FutureBuilder(
            future: _dio.get("https://api.github.com/orgs/flutterchina/repos",
                options: Options(
                  // TODO 解决 “flutter FormatException: Unexpected character (at character ... ” 问题
                  // https://blog.csdn.net/yechaoa/article/details/93044925
                  /// TODO 003：这里要写成 ResponseType.plain 才能正确返回（是否是数据源本身的问题？？？）
                  responseType: ResponseType.plain,
                )),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                // TODO dart:convert中内置的JSON解码器json.decode()（序列化---反序列化：String json = json.encode(bean)）
                var decode = json.decode(snapshot.data.toString());
                FlutterChinaRepos bean = FlutterChinaRepos.fromJson(decode);
                List<FlutterChinaReposItem> dataList = bean.data;
                FlutterChinaReposItem firstData = dataList[0];
                return Text("name:" + firstData.name);
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
