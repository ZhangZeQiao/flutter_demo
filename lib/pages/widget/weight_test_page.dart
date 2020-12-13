import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetTestPage extends StatefulWidget {
  WidgetTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  TextEditingController _textFieldController = new TextEditingController();
  String _phone = "";

  bool _isNumberAndCount(String str) {
    return str.length <= 11 && new RegExp("^[0-9][0-9]*\$").hasMatch(str);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: TextField(
        keyboardType: TextInputType.number,
        controller: _textFieldController,
        decoration: InputDecoration(
          hintText: "请输入手机号码",
          hintStyle: TextStyle(color: Color(0xffbfbfbf), fontSize: 16),
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffebebeb), width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffebebeb), width: 1),
          ),
        ),
        onChanged: (v) {
          if (_isNumberAndCount(v) || v == "") {
            setState(() {
              _phone = v;
            });
          } else {
            _textFieldController.text = _phone;
            _textFieldController.selection = TextSelection.fromPosition(
              // 保持光标在最后
              TextPosition(
                  affinity: TextAffinity.downstream, offset: _phone.length),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
