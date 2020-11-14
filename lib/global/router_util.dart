import 'package:flutter/widgets.dart';
import 'package:flutter_demo/pages/future/future_test_page.dart';

import '../main.dart';

const String ROUTE_HOME = '/home';
const String ROUTE_FUTURE_TEST = '/future_test';

final Map<String, WidgetBuilder> pageRoutes = {
  ROUTE_HOME: (context) => MyHomePage(title: '首页'),
  ROUTE_FUTURE_TEST: (context) => FutureTestPage(title: 'Future 测试页'),
};
