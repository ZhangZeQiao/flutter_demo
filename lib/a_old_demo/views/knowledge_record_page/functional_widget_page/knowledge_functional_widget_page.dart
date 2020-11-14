import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/functional_widget_page/functional_widget_001_page.dart';

class KnowledgeFunctionalWidgetPage extends StatefulWidget {
  final String title;

  KnowledgeFunctionalWidgetPage({Key key, this.title = "功能型组件"})
      : super(key: key);

  @override
  _KnowledgeFunctionalWidgetPageState createState() =>
      _KnowledgeFunctionalWidgetPageState();
}

class _KnowledgeFunctionalWidgetPageState
    extends State<KnowledgeFunctionalWidgetPage> {
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
    _pageName.add("数据共享（InheritedWidget）");
    _pageWidget.add(FunctionalWidget001Page());
  }
}
