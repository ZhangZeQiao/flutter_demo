import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/animation_001_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/animation_002_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/animation_003_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/animation_004_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/animation_page/animation_005_page.dart';

class KnowledgeAnimationPage extends StatefulWidget {
  final String title;

  KnowledgeAnimationPage({Key key, this.title = "动画相关"}) : super(key: key);

  @override
  _KnowledgeAnimationPageState createState() => _KnowledgeAnimationPageState();
}

class _KnowledgeAnimationPageState extends State<KnowledgeAnimationPage> {
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
    _pageName.add("匀速动画和非匀速动画");
    _pageWidget.add(Animation001Page());

    _pageName.add("用AnimatedWidget从动画中分离出widget");
    _pageWidget.add(Animation002Page());

    _pageName.add("用AnimatedBuilder将渲染逻辑分离出来");
    _pageWidget.add(Animation003Page());

    _pageName.add("封装一个动画");
    _pageWidget.add(Animation004Page());

    _pageName.add("动画状态监听");
    _pageWidget.add(Animation005Page());
  }
}
