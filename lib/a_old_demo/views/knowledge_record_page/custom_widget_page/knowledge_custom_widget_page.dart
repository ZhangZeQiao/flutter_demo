import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/custom_widget_page/custom_001_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/custom_widget_page/custom_002_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/custom_widget_page/custom_003_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/custom_widget_page/custom_004_page.dart';

class KnowledgeCustomWidgetPage extends StatefulWidget {
  final String title;

  KnowledgeCustomWidgetPage({Key key, this.title = "自定义 Widget"})
      : super(key: key);

  @override
  _KnowledgeCustomWidgetPageState createState() =>
      _KnowledgeCustomWidgetPageState();
}

class _KnowledgeCustomWidgetPageState extends State<KnowledgeCustomWidgetPage> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return _pageWidget[index];
                }));
              },
            );
          }),
    );
  }

  void _initListData() {
    _pageName.add("组合 Widget：GradientButton");
    _pageWidget.add(Custom001Page());

    _pageName.add("组合 Widget：TurnBox");
    _pageWidget.add(Custom002Page());

    _pageName.add("自绘 Widget：五子棋/盘");
    _pageWidget.add(Custom003Page());

    _pageName.add("自绘 Widget：圆形背景渐变进度条");
    _pageWidget.add(GradientCircularProgressRoute());
  }
}
