import 'package:flutter/material.dart';

import '../../../main.dart';

class OfficialPage extends StatefulWidget {
  final String title;

  OfficialPage({Key key, this.title}) : super(key: key);

  @override
  _OfficialPageState createState() => _OfficialPageState();
}

class _OfficialPageState extends State<OfficialPage> {
  // Map<int, Map<String, Widget>> _pageMap = {};

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
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: RaisedButton(
              child: Text(_pageName[index]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return _pageWidget[index];
                  },
                ));
              },
            ),
          );
        },
      ),
    );
  }

  void _initPageData() {
    _pageName.add("AndroidStudio 第一个 Flutter Demo");
    _pageWidget.add(MyHomePage(title: 'Flutter Demo Home Page'));
  }
}
