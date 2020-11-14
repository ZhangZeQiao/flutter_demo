import 'package:flutter/material.dart';

class Knowledge003Page extends StatefulWidget {
  final String title;

  Knowledge003Page({Key key, this.title = "图片加载"}) : super(key: key);

  @override
  _Knowledge003PageState createState() => _Knowledge003PageState();
}

class _Knowledge003PageState extends State<Knowledge003Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("通过AssetImage加载本地图片:"),
                Container(
                  color: Color(0xFFFF0000),
                  child: Image(
                    image: AssetImage("assets/images/icon_switch_close.png"),
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("通过Image.asset加载本地图片:"),
                Container(
                  color: Color(0xFFFF0000),
                  child: Image.asset(
                    "assets/images/icon_switch_close.png",
                    // TODO 默认模式下，设置Image的宽高后，图片会按照宽高中的最小边来定比例基准，图片会按照比例放大缩小，不会拉伸
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("通过NetworkImage加载本地图片:"),
                Container(
                  color: Color(0xFF000000),
                  child: Image(
                    image: NetworkImage(
                        "https://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=https%3A%2F%2Ftimgsa.baidu.com%2Ftimg%3Fimage%26quality%3D80%26size%3Db9999_10000%26sec%3D1577960161589%26di%3D79c55e3dd354a5214596880cbc8fcad3%26imgtype%3D0%26src%3Dhttp%253A%252F%252Fwww.jiadego.com%252Ffiles%252F2013%252F0801%252F1306150976283066%252Fzsucai13061523120857.png&thumburl=https%3A%2F%2Fss3.bdstatic.com%2F70cFv8Sh_Q1YnxGkpoWK1HF6hhy%2Fit%2Fu%3D3138005451%2C1224401176%26fm%3D15%26gp%3D0.jpg"),
                    width: 30,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("通过Image.network加载本地图片:"),
                Container(
                  color: Color(0xFF000000),
                  child: Image.network(
                    "https://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=https%3A%2F%2Ftimgsa.baidu.com%2Ftimg%3Fimage%26quality%3D80%26size%3Db9999_10000%26sec%3D1577960161589%26di%3D79c55e3dd354a5214596880cbc8fcad3%26imgtype%3D0%26src%3Dhttp%253A%252F%252Fwww.jiadego.com%252Ffiles%252F2013%252F0801%252F1306150976283066%252Fzsucai13061523120857.png&thumburl=https%3A%2F%2Fss3.bdstatic.com%2F70cFv8Sh_Q1YnxGkpoWK1HF6hhy%2Fit%2Fu%3D3138005451%2C1224401176%26fm%3D15%26gp%3D0.jpg",
                    width: 50,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
