import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/network_page/network_001_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/network_page/network_002_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/network_page/network_003_page.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/network_page/network_004_page.dart';

class KnowledgeNetworkPage extends StatefulWidget {
  final String title;

  KnowledgeNetworkPage({Key key, this.title = "网络相关"}) : super(key: key);

  @override
  _KnowledgeNetworkPageState createState() => _KnowledgeNetworkPageState();
}

class _KnowledgeNetworkPageState extends State<KnowledgeNetworkPage> {
  List<String> _pageName = [];
  List<Widget> _pageWidget = [];

  @override
  void initState() {
    super.initState();
    _initPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _pageWidget.length,
        itemBuilder: (context, int index) {
          return RaisedButton(
            child: Text(_pageName[index]),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return _pageWidget[index];
                },
              ));
            },
          );
        },
      ),
    );
  }

  void _initPageData() {
    _pageName.add("通过HttpClient发起HTTP请求");
    _pageWidget.add(Network001Page());

    _pageName.add("Http请求库：Dio");
    _pageWidget.add(Network002Page());

    _pageName.add("Http（dio）分块下载");
    _pageWidget.add(Network003Page());

    _pageName.add("Json解析");
    _pageWidget.add(Network004Page());
  }
}
