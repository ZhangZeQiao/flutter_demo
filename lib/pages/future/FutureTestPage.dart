import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureTestPage extends StatefulWidget {
  FutureTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _FutureTestPageState();
}

class _FutureTestPageState extends State<FutureTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: RaisedButton(
        child: Text('测试'),
        onPressed: _demo,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _demo() {
    print("initState:${DateTime.now()}");
    _loadUserInfo();
    print("initState:${DateTime.now()}");
  }

  Future _getUserInfo() async {
    await Future.delayed(Duration(seconds: 3));
    return '我是用户';
  }

  Future _loadUserInfo() async {
    /*
    I/flutter ( 5255): initState:2020-10-20 09:39:55.798376
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:39:55.804968
    I/flutter ( 5255): initState:2020-10-20 09:39:55.809743
    I/flutter ( 5255): 我是用户
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:39:58.814776
    */
    /*print('_loadUserInfo:${new DateTime.now()}');
    // TODO await 会阻塞流程，等待紧跟着的的 Future 执行完毕之后，再执行下一条语句
    print(await _getUserInfo());
    print('_loadUserInfo:${new DateTime.now()}');*/

    /*
    I/flutter ( 5255): initState:2020-10-20 09:38:39.822147
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:38:39.830940
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:38:39.837982
    I/flutter ( 5255): initState:2020-10-20 09:38:39.838884
    I/flutter ( 5255): 我是用户
    */
    print('_loadUserInfo:${DateTime.now()}');
    // TODO Future.then 这个 api，那么就不会等待，直接执行下面的语句，等 Future 执行完了，再调用 then 这个方法
    _getUserInfo().then((info) {
      print(info);
    });
    print('_loadUserInfo:${DateTime.now()}');
  }
}
