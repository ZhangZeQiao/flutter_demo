import 'package:flutter/widgets.dart';
import 'package:flutter_demo/pages/future/FutureTestPage.dart';

import '../main.dart';

class RouterManager {
  static String ROUTE_HOME = '/home';
  static String ROUTE_FUTURE_TEST = '/future_test';

  static Map<String, WidgetBuilder> routes = {
    ROUTE_HOME: (context) => MyHomePage(title: '首页'),
    ROUTE_FUTURE_TEST: (context) => FutureTestPage(title: 'Future 测试页'),
  };
}
