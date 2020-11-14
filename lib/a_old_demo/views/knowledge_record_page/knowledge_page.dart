import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/android_function_page/knowledge_a_function_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/knowledge_animation_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/custom_widget_page/knowledge_custom_widget_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/functional_widget_page/knowledge_functional_widget_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/network_page/knowledge_network_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/other_page/knowledge_001_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/other_page/knowledge_002_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/other_page/knowledge_003_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/webview_page/knowledge_webview_page.dart';

class KnowledgePage extends StatefulWidget {
  final String title;

  KnowledgePage({Key key, this.title}) : super(key: key);

  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  List<String> _pageName = [];
  List<Widget> _pageWidget = [];

  @override
  void initState() {
    super.initState();
    _initListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
          ),
        ),
        body: ListView.builder(
            itemCount: _pageWidget.length,
            // itemExtent: 50.0, // TODO 强制高度为 50.0
            itemBuilder: (context, index) {
              return Padding(
                // TODO padding四个方向分别设置
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: RaisedButton(
                  child: Text(_pageName[index] ?? "Name 为空"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return _pageWidget[index];
                    }));
                  },
                ),
              );
            }));
  }

  void _initListData() {
    _pageName.add("padding不同用法、宽高背景gravity");
    _pageWidget.add(Knowledge001Page());

    _pageName
        .add("SharedPreferences、Fluttertoast、异步操作后更新数据、点击监听GestureDetector");
    _pageWidget.add(Knowledge002Page());

    _pageName.add("图片加载");
    _pageWidget.add(Knowledge003Page());

    _pageName.add("网络相关");
    _pageWidget.add(KnowledgeNetworkPage());

    _pageName.add("Android系统功能相关");
    _pageWidget.add(KnowledgeAFunctionPage());

    _pageName.add("动画相关");
    _pageWidget.add(KnowledgeAnimationPage());

    _pageName.add("WebView 相关");
    _pageWidget.add(KnowledgeWebViewPage());

    _pageName.add("自定义 Widget");
    _pageWidget.add(KnowledgeCustomWidgetPage());

    _pageName.add("功能型组件");
    _pageWidget.add(KnowledgeFunctionalWidgetPage());
  }
}
