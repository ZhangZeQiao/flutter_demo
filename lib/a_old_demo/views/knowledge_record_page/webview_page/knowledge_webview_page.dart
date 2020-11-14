import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/webview_page/webview_001_page.dart';

class KnowledgeWebViewPage extends StatefulWidget {
  final String title;

  KnowledgeWebViewPage({Key key, this.title = "WebView 相关"}) : super(key: key);

  @override
  _KnowledgeWebViewPageState createState() => _KnowledgeWebViewPageState();
}

class _KnowledgeWebViewPageState extends State<KnowledgeWebViewPage> {
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
          }),
    );
  }

  void _initListData() {
    _pageName.add("用WebView打开百度");
    _pageWidget.add(WebView001Page());
  }
}
