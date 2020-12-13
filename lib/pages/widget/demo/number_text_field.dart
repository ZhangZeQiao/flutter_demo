import 'package:flutter/material.dart';

/// 自定义数字输入框（字母）
/// [limitCount] 限制可输入长度
/// [canInputLetter] 能否输入英文字母
class NumberTextField extends StatefulWidget {
  final int limitCount;
  final bool canInputLetter;
  final TextStyle style;
  final TextEditingController controller;
  final InputDecoration decoration;
  final ValueChanged<String> onChanged;

  NumberTextField({
    Key key,
    this.limitCount = 0,
    this.canInputLetter = false,
    this.style,
    this.controller,
    this.decoration = const InputDecoration(),
    this.onChanged,
  })  : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _NumberTextFieldState(limitCount, canInputLetter, controller);
}

class _NumberTextFieldState extends State<NumberTextField> {
  final int _limitCount;
  final bool _canInputLetter;
  final TextEditingController _textFieldController;
  String _number = '';

  _NumberTextFieldState(
      this._limitCount, this._canInputLetter, this._textFieldController);

  bool _isNumberAndCount(String str) {
    return (_limitCount <= 0 || str.length <= _limitCount) &&
        (_canInputLetter
            ? RegExp("^[a-z0-9A-Z]*\$").hasMatch(str)
            : RegExp("^[0-9]*\$").hasMatch(str));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.style,
      keyboardType: TextInputType.number,
      controller: _textFieldController,
      decoration: widget.decoration,
      /*inputFormatters: [FilteringTextInputFormatter.deny(
          // 过滤表情包，好像_isNumberAndCount已经过滤了，不行才放开
          RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"))],*/
      onChanged: (v) {
        if (_isNumberAndCount(v) || v == "") {
          setState(() {
            _number = v;
          });
          if (widget.onChanged != null) {
            widget.onChanged(v);
          }
        } else {
          _textFieldController.text = _number;
          _textFieldController.selection = TextSelection.fromPosition(
            // 保持光标在最后
            TextPosition(
                affinity: TextAffinity.downstream, offset: _number.length),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
