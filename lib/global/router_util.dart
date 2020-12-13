import 'package:flutter/widgets.dart';
import 'package:flutter_demo/pages/future/future_test_page.dart';
import 'package:flutter_demo/pages/widget/weight_test_page.dart';

import '../main.dart';

const String ROUTE_HOME = '/home';
const String ROUTE_FUTURE_TEST = '/future_test';
const String ROUTE_WIDGET_TEST = '/widget_test';

final Map<String, WidgetBuilder> pageRoutes = {
  ROUTE_HOME: (context) => MyHomePage(title: '首页'),
  ROUTE_FUTURE_TEST: (context) => FutureTestPage(title: 'Future 测试页'),
  ROUTE_WIDGET_TEST: (context) => WidgetTestPage(title: 'UI weight 测试页'),
};
