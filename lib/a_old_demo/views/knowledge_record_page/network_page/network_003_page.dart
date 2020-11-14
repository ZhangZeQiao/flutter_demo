import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Network003Page extends StatefulWidget {
  final String title;

  Network003Page({Key key, this.title = "Http（dio）分块下载"}) : super(key: key);

  @override
  _Network003PageState createState() => _Network003PageState();
}

class _Network003PageState extends State<Network003Page> {
  int _progress = 0;

  String _path = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("dio分块下载"),
            onPressed: () {
              _download();
              // _pathTest();
            },
          ),
          Text(_path),
          Text("下载进度：" + _progress.toString()),
        ],
      ),
    );
  }

  /*
  * TODO async/await只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。
  *
  * login("alice","******").then((id){
  *       return getUserInfo(id);
  * }).then((userInfo){
  *     return saveUserInfo(userInfo);
  * }).then((e){
  *    //执行接下来的操作
  * }).catchError((e){
  *   //错误处理
  *   print(e);
  * });
  * 
  * TODO 以上代码可以简化为以下代码（async/await语法糖：将Future<Xxx>的then简化，直接返回Xxx对象）：
  *
  * task() async {
  *    try{
  *     String id = await login("alice","******");
  *     String userInfo = await getUserInfo(id);
  *     await saveUserInfo(userInfo);
  *     //执行接下来的操作   
  *    } catch(e){
  *     //错误处理   
  *     print(e);   
  *    }  
  * }
  * */
  Future<void> _download() async {
    var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
    Directory directory = await getExternalStorageDirectory();
    setState(() {
      _path = directory.path;
    });
    var savePath = directory.path + "/HBuilder.9.0.2.macosx_64.dmg";
    downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        setState(() {
          _progress = (received / total * 100).floor();
        });
      } else {
        Fluttertoast.showToast(msg: "下载完成");
      }
    });
  }

  Directory appDocumentsDirectory;
  Directory appSupportDirectory;
  List<Directory> appExternalCacheDirectories;
  Directory appExternalStorageDirectory;
  Directory appLibraryDirectory;
  Directory appTemporaryDirectory;

  Future<void> _pathTest() async {
    appDocumentsDirectory = await getApplicationDocumentsDirectory();// /data/user/0/com.zzq.flutter_demo/app_flutter
    appSupportDirectory = await getApplicationSupportDirectory();// /data/user/0/com.zzq.flutter_demo/files
    appExternalCacheDirectories = await getExternalCacheDirectories();// /storage/emulated/0/Android/data/com.zzq.flutter_demo/cache
    appExternalStorageDirectory = await getExternalStorageDirectory();// /storage/emulated/0/Android/data/com.zzq.flutter_demo/files
    // appLibraryDirectory = await getLibraryDirectory();// 例如 sqlite.db
    appTemporaryDirectory = await getTemporaryDirectory();// /data/user/0/com.zzq.flutter_demo/cache
  }
}

Future downloadWithChunks(url, savePath,
    {ProgressCallback onReceiveProgress}) async {
  const firstChunkSize = 102;
  const maxChunk = 3;

  int total = 0;
  var dio = Dio();
  var progress = <int>[];

  createCallback(no) {
    // TODO ???
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(progress.reduce((a, b) => a + b), total);
      }
    };
  }

  Future<Response> downloadChunk(url, start, end, no) {
    progress.add(0);
    --end;
    return dio.download(
      // TODO dio-3.0.7\lib\src\entry\dio_for_native.dart -- Future<Response> download(...){...}
      url,
      savePath + "temp$no", // 临时文件按照块的序号命名，方便最后合并
      onReceiveProgress: createCallback(no),
      options: Options(
        headers: {"range": "bytes=$start-$end"}, // 指定请求的内容区间
      ),
    );
  }

  Future mergeTempFiles(chunk) async {
    File file = File(savePath + "temp0");
    IOSink ioSink = file.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await file.rename(savePath);
  }

  // 通过第一个分块请求检测服务器是否支持分块传输
  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  // 206为支持
  if (response.statusCode == 206) {
    // 解析文件总长度，进而计算出剩余长度
    total = int.parse(
        response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
    int reserved = total -
        int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
    // 文件的总块数（包括第一块）
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; ++i) {
        int start = firstChunkSize + i * chunkSize;
        // 分块下载剩余文件
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      // 等待所有分块全部下载完成
      await Future.wait(
          futures); // Waits for multiple futures to complete and collects their results.
    }
    // 合并文件文件
    await mergeTempFiles(chunk);
  }
}
