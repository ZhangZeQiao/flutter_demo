import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView001Page extends StatefulWidget {
  final String title;

  WebView001Page({Key key, this.title = "用WebView打开百度"}) : super(key: key);

  @override
  _WebView001PageState createState() => _WebView001PageState();
}

class _WebView001PageState extends State<WebView001Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _showWebView(context),
    );
  }

  Widget _showWebView(BuildContext context) {
    return WebView(
      // 初始url
      initialUrl: "https://www.baidu.com/",
      // js执行模式
      javascriptMode: JavascriptMode.unrestricted,
      // 在WebView创建完成后调用，只会被调用一次
      onWebViewCreated: (WebViewController controller) {},
      // JS和Flutter通信的Channel
      javascriptChannels: <JavascriptChannel>[].toSet(),
      // 路由委托（可以通过在此处拦截url实现JS调用Flutter部分）
      navigationDelegate: (NavigationRequest navigation) {},
      // 页面开始加载回调
      onPageStarted: (String url) {},
      // 页面加载完成回调
      onPageFinished: (String url) {},
    );
  }
}
