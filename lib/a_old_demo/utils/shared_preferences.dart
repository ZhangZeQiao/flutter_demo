/*export 'package:flutter_demo/resources/shared_preferences_keys.dart';*/

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil _instance;
  static SharedPreferences _spf;

  // TODO instance 是什么？？ 这一整条语法是什么？？
  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  SpUtil._(); // TODO 私有化构造函数

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = SpUtil._();
    }
    if (_spf == null) {
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    return _spf == null;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  String getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }

/**
 * TODO ⬆ 模式一
 * TODO ⬇ 模式二
 */

/*static Future<bool> setBool(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }*/

}
