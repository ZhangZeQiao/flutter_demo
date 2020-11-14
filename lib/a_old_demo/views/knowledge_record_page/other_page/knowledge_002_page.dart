import 'package:flutter/material.dart';
import 'package:flutter_demo/a_old_demo/resources/shared_preferences_keys.dart';
import 'package:flutter_demo/a_old_demo/utils/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Knowledge002Page extends StatefulWidget {
  final String title;

  Knowledge002Page(
      {Key key,
      this.title =
          "SharedPreferences、Fluttertoast、异步操作后更新数据、点击监听GestureDetector"})
      : super(key: key);

  @override
  _Knowledge002PageState createState() => _Knowledge002PageState();
}

class _Knowledge002PageState extends State<Knowledge002Page> {
  SpUtil _sp;
  bool _changeColor = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _sp = await SpUtil.getInstance();
    setState(() {
      _changeColor =
          _sp.getBool(SharedPreferencesKeys.SETTING_PAGE_CHANGE_COLOR) ?? false;
      // TODO 在获取某个key的value之前没有设置过此key的value，那么获取到的值就为null，需要给出一个默认值
    });
    /**
     * TODO ⬆ 模式一
     * TODO ⬇ 模式二
     */
    /*Future<bool> result =
        SpUtil.getBool(SharedPreferencesKeys.SETTING_PAGE_CHANGE_COLOR);
    result.then((value) {
    
      /* TODO 在获取值的时候使用了异步操作，需要在值获取之后再执行相关方法，
      部分方法需要放到获取方法的 then里面去执行，确保获取到需要的值*/
    
      setState(() {
        if (value == null) {
          _ChangeColor = false;
        } else {
          _ChangeColor = value;
        }
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),
              color: Color(0xFFFFCDD2),
              child: Row(
                // TODO wrap_content
                // mainAxisSize: MainAxisSize.min,
                //  TODO match_parent
                mainAxisSize: MainAxisSize.max,
                // TODO Row 的左右开弓
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    color: Color(0xFFEF5350),
                    child: Text(
                      _changeColor ? "你看，我是白色" : "你看，我是黑色",
                      style: TextStyle(
                        color: _changeColor ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _changeColor = !_changeColor;
                        _sp.putBool(
                            SharedPreferencesKeys.SETTING_PAGE_CHANGE_COLOR,
                            _changeColor);
                        /**
                         * TODO ⬆ 模式一
                         * TODO ⬇ 模式二
                         */
                        /*SpUtil.setBool(
                            SharedPreferencesKeys.SETTING_PAGE_CHANGE_COLOR,
                            _ChangeColor);*/
                      });
                    },
                    child: Container(
                      color: Color(0xFFB71C1C),
                      child: Image(
                        image: _changeColor
                            ? AssetImage("assets/images/icon_switch_open.png")
                            : AssetImage("assets/images/icon_switch_close.png"),
                        width: 40.0,
                        height: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),
              color: Color(0xFFCDFFD2),
              // TODO Stack + Align 实现的左右开弓（定位）
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(right: 5.0),
                      color: Color(0xFF53EF50),
                      child: Text(
                        _changeColor ? "你看，我是黑色" : "你看，我是白色",
                        style: TextStyle(
                          color: _changeColor ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO Toast
                        Fluttertoast.showToast(
                          msg: "去去去，点上面的！",
                          textColor: Colors.black,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                        );
                      },
                      child: Container(
                        color: Color(0xFF1CB71C),
                        child: Image(
                          image: _changeColor
                              ? AssetImage("assets/images/icon_switch_open.png")
                              : AssetImage(
                                  "assets/images/icon_switch_close.png"),
                          width: 40.0,
                          height: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
