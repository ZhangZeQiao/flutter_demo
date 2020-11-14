// TODO https://javiercbk.github.io/json_to_dart/

class FlutterChinaRepos {
  List<FlutterChinaReposItem> data;

  FlutterChinaRepos({this.data});

  /// TODO type 'List<dynamic>' is not a subtype of type 'List<FlutterChinaReposItem>'
  /// Flutter 中的 JSON 解析：https://www.jianshu.com/p/8a13e70e4a4a
  /// TODO 002：这里要写成 List<dynamic> json 形式才能正确返回，不能写成 dynamic json
  FlutterChinaRepos.fromJson(List<dynamic> json) {
    // TODO 将 List<dynamic> 转成 List<FlutterChinaReposItem>
    List<FlutterChinaReposItem> beanData =
        json.map((value) => FlutterChinaReposItem.fromJson(value)).toList();
    data = beanData;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "data": data,
    };
  }
}

class FlutterChinaReposItem {
  num id;
  String name;
  String html_url;
  String description;
  num size;

  FlutterChinaReposItem(
      {this.id, this.name, this.html_url, this.description, this.size});

  // TODO 001：方式一、方式二才能正确返回，方式三是错误写法
  /// TODO 方式一
  factory FlutterChinaReposItem.fromJson(dynamic json) {
    return FlutterChinaReposItem(
      id: json["id"],
      name: json["name"],
      html_url: json["html_url"],
      description: json["description"],
      size: json["size"],
    );
  }

  /// TODO 方式二
  /*FlutterChinaReposItem.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    html_url = json["html_url"];
    description = json["description"];
    size = json["size"];
  }*/

  /// TODO 方式三
  /*FlutterChinaReposItem.fromJson(dynamic json) {
    FlutterChinaReposItem(
      id: json["id"],
      name: json["name"],
      html_url: json["html_url"],
      description: json["description"],
      size: json["size"],
    );
  }*/

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "html_url": html_url,
      "description": description,
      "size": size,
    };
  }
}
