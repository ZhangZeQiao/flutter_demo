import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class AFunction003Page extends StatefulWidget {
  final String title;

  AFunction003Page({Key key, this.title = "相机"}) : super(key: key);

  @override
  _AFunction003PageState createState() => _AFunction003PageState();
}

class _AFunction003PageState extends State<AFunction003Page>
    with WidgetsBindingObserver {
  List<CameraDescription> cameras;

  CameraController controller;
  String imagePath; // 图片保存路径
  String videoPath; // 视频保存路径
  VideoPlayerController videoPlayerController; // 用于播放录制的视频
  VoidCallback videoPlayerListener;
  bool enableAudio = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // TODO 监听APP状态改变，是否在前台
    WidgetsBinding.instance.addObserver(this);
    _initCamerasList();
  }

  _initCamerasList() async {
    // 获取可用摄像头列表
    cameras = await availableCameras();
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO 如果APP不在前台
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // TODO 在前台
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // TODO
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: cameras == null
          ? const Text("等一等哈 ~")
          : Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: controller != null &&
                                controller.value.isRecordingVideo
                            ? Colors.redAccent
                            : Colors.grey,
                        width: 3.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: _cameraPreviewWidget(),
                      ),
                    ),
                  ),
                ),
                _captureControlRowWidget(),
                _toggleAudioWidget(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _cameraTogglesRowWidget(),
                      _thumbnailWidget(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    // TODO 解除监听
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // TODO 摄像头选中回调
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: enableAudio,
    );

    controller.addListener(() {
      // TODO Whether this [State] object is currently in a tree.这个[State]对象当前是否在树中。
      if (mounted) {
        setState(() {});
      }
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException error) {
    logError(error.code, error.description);
    showInSnackBar("Error:${error.code}\n${error.description}");
  }

  void logError(String code, String description) {
    print("Error:$code\nError Message:$description");
  }

  /// 展示预览窗口
  _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        "选择一个摄像头",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// 相机工具栏
  _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
          // TODO 这里要的是函数类型的数据，不能写成 onTakePictureButtonPressed()，不然就是函数返回变量的类型数据了
          // TODO final VoidCallback onPressed;   typedef VoidCallback = void Function();
          // TODO type '(String) => Null' is not a subtype of type '(dynamic) => FutureOr<dynamic>' of 'f'
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        ),
      ],
    );
  }

  /// 开启或关闭录音
  _toggleAudioWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          const Text("开启录音"),
          Switch(
            value: enableAudio,
            onChanged: (bool value) {
              enableAudio = value;
              if (controller != null) {
                onNewCameraSelected(controller.description);
              }
            },
          )
        ],
      ),
    );
  }

  /// 展示所有摄像头
  _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];
    if (cameras.isEmpty) {
      return const Text("没有检测到摄像头");
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(SizedBox(
          width: 90.0,
          child: RadioListTile<CameraDescription>(
            title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
            groupValue: controller?.description,
            value: cameraDescription,
            onChanged: controller != null && controller.value.isRecordingVideo
                ? null
                : onNewCameraSelected,
          ),
        ));
      }
    }
    return Row(children: toggles);
  }

  /// 显示已拍摄的图片/视频缩略图
  _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoPlayerController == null && imagePath == null
                ? Container()
                : SizedBox(
                    child: (videoPlayerController == null)
                        ? Image.file(File(imagePath))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: videoPlayerController.value.size !=
                                        null
                                    ? videoPlayerController.value.aspectRatio
                                    : 1.0,
                                child: VideoPlayer(videoPlayerController),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink),
                            ),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }

  // 拍照按钮点击回调
  onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoPlayerController?.dispose();
          videoPlayerController = null;
        });
        if (filePath != null) {
          showInSnackBar("图片保存在$filePath");
        }
      }
    });
  }

  // 开始录制视频
  onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) {
        setState(() {
          showInSnackBar("正在保存视频与$filePath");
        });
      }
    });
  }

  // 终止视频录制
  onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) {
        setState(() {
          showInSnackBar("视频保存在$videoPath");
        });
      }
    });
  }

  takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('错误: 请先选择一个相机');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar("请先选择一个摄像头");
      return null;
    }

    // 确定视频保存的路径
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = "${extDir.path}/Movies/flutter_test";
    await Directory(dirPath).create(recursive: true);
    final String filePath = "$dirPath/${timestamp()}.mp4";

    if (controller.value.isRecordingVideo) {
      // 如果正在录制，则直接返回
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoPlayerController != null &&
          videoPlayerController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoPlayerController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoPlayerController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoPlayerController = vcontroller;
      });
    }
    await vcontroller.play();
  }

  String timestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 获取不同摄像头的图标（前置、后置、其它）
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }
}
