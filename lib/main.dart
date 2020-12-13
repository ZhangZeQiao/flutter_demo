import 'package:flutter/material.dart';
import 'package:flutter_demo/global/router_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter 测试用例（Android Kotlin）'),
      routes: pageRoutes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _pageRoutes = [
    ROUTE_FUTURE_TEST,
    ROUTE_WIDGET_TEST,
  ];
  List<String> _pageNames = [
    'Future 测试页',
    'UI weight 测试页',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
        ),
        itemCount: _pageRoutes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text(_pageNames[index] ?? 'Name 为空'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(_pageRoutes[index] ?? ROUTE_HOME);
              },
            ),
          );
        },
      ),
    );
  }
}
