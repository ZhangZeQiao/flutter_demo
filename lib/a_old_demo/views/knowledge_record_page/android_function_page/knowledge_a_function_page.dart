import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/android_function_page/a_function_001_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/android_function_page/a_function_002_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/android_function_page/a_function_003_page.dart';

class KnowledgeAFunctionPage extends StatefulWidget {
  final String title;

  KnowledgeAFunctionPage({Key key, this.title = "Android系统功能相关"})
      : super(key: key);

  @override
  _KnowledgeAFunctionPageState createState() => _KnowledgeAFunctionPageState();
}

class _KnowledgeAFunctionPageState extends State<KnowledgeAFunctionPage> {
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
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _pageWidget.length,
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
            child: Text(_pageName[index]),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return _pageWidget[index];
              }));
            },
          );
        },
      ),
    );
  }

  void _initListData() {
    _pageName.add("通知栏（Notification）");
    _pageWidget.add(AFunction001Page());

    _pageName.add("获取电池电量");
    _pageWidget.add(AFunction002Page());

    _pageName.add("相机");
    _pageWidget.add(AFunction003Page());
  }
}
