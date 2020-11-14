import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/views/knowledge_record_page/knowledge_page.dart';
import 'package:flutter_demo/a_old_demo/views/official_demo_page/official_page.dart';

// SpUtil sp;

Future<void> main() async {
  /**
   * TODO
   * If you're running an application and need to access the binary messenger
   * before `runApp()` has been called (for example, during plugin initialization),
   * then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
   * */
  WidgetsFlutterBinding.ensureInitialized();

  // sp = await SpUtil.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyTestDemoPage(title: 'Flutter 测试用例（不copy手写每一行代码）'),
    );
  }
}

// TODO ------------- My Test Demo -------------

class MyTestDemoPage extends StatefulWidget {
  MyTestDemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyTestDemoPageState createState() => _MyTestDemoPageState();
}

class _MyTestDemoPageState extends State<MyTestDemoPage> {
  List<String> _pageName = [];
  List<Widget> _pageWidget = [];

  @override
  void initState() {
    // TODO 初始化数据
    super.initState();
    _initPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.66,
          ),
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // TODO The ratio of the cross-axis to the main-axis extent of each child.
            childAspectRatio: 3,
          ),
          itemCount: _pageWidget.length, // TODO 如果为null，则列表无穷大
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text(_pageName[index] ?? "Name 为空"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return _pageWidget[index];
                  }));
                },
              ),
            );
          }),
    );
  }

  void _initPageData() {
    _pageName.add("官方 Demo");
    _pageWidget.add(OfficialPage(title: '官方 Demo'));

    _pageName.add("知识点记录页");
    _pageWidget.add(KnowledgePage(title: '知识点记录页'));
  }
}
