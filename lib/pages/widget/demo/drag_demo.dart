import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragDemoPage extends StatefulWidget {
  @override
  _DragDemoPageState createState() => _DragDemoPageState();
}

class _DragDemoPageState extends State {
  List<String> _dataList = [
    "1", "2", "3", "4", "5", "6",
    "7", "8", "9", "10", "11", "12",
    "13", "14", "15", "16", "17", "18",
    "19", "20"
  ];
  String _top = "-A-";
  ScrollController _scrollController = new ScrollController();
  int _lastTargetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag"),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("长按图标拖动调整排序"),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        children: [
          _buildTop(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                controller: _scrollController,
                children: _dataList
                    .asMap()
                    .keys
                    .map((index) => _buildDraggableItem(index))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return DragTarget<int>(
      builder: (context, data, rejects) {
        return Column(
          children: [
            Image(
              image: AssetImage("assets/images/icon_switch_open.png"),
              width: 140,
              height: 140,
              fit: BoxFit.contain,
            ),
            Text("冠军：$_top"),
          ],
        );
      },
      onLeave: (data) {},
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          final temp = _dataList[data];
          _dataList.remove(temp);
          _dataList.insert(data, _top);
          _top = temp;
        });
      },
    );
  }

  Widget _buildDraggableItem(int index) {
    // TODO LongPressDraggable 继承自 Draggable，因此用法和 Draggable 完全一样，
    // TODO 唯一的区别就是 LongPressDraggable 触发拖动的方式是长按，而 Draggable 触发拖动的方式是按下
    return LongPressDraggable(
      // TODO 传递给 DragTarget 的数据
      data: index,
      // TODO 拖动时跟随移动的 widget
      feedback: _buildItem(_dataList[index], isDragging: true),
      // TODO 用 DragTarget 包裹，表示可作为拖动的最终目标，<int>表示传递数据 data 的类型
      child: DragTarget<int>(
        builder: (context, data, rejects) {
          return _buildItem(_dataList[index]);
        },
        // 手指拖着一个widget从另一个widget头上滑走时会调用
        onLeave: (data) {
          // print('---$data is Leaving item $index---');
        },
        // 松手时，是否需要将数据给这个widget，因为需要在拖动时改变UI，所以在这里直接修改数据源
        onWillAccept: (data) {
          // print('---(target)$index will accept item (drag)$data---');
          // TODO 跨度超过一行数量，就是判定可以上/下滑动
          if ((index - _lastTargetIndex).abs() >= 3) {
            _scrollController.jumpTo(((index / 3).ceil() - 1) * 80.0); // 80为item高度
            setState(() {
              _lastTargetIndex = index;
            });
          }
          return true;
        },
        // 松手时，如果onWillAccept返回true，那么就会调用
        onAccept: (data) {
          // TODO 松手时交换数据并刷新 UI
          setState(() {
            final dragTemp = _dataList[index];
            final targetTemp = _dataList[data];
            _dataList.replaceRange(data, data + 1, [dragTemp]);
            _dataList.replaceRange(index, index + 1, [targetTemp]);
          });
        },
      ),
      /*// 开始拖动时回调
      onDragStarted: () {print('---1---onDragStarted');},
      // 拖动结束时回调
      onDragEnd: (DraggableDetails details) {print('---2---onDragEnd:$details');},
      // 未拖动到DragTarget控件上时回调
      onDraggableCanceled: (Velocity velocity, Offset offset) {print('---3---onDraggableCanceled velocity:$velocity,offset:$offset');},
      // 拖动到DragTarget控件上时回调
      onDragCompleted: () {print('---4---onDragCompleted');},*/
    );
  }

  Widget _buildItem(String item, {bool isDragging = false}) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/icon_switch_open.png"),
            width: isDragging ? 88 : 55,
            height: isDragging ? 88 : 55,
            color: isDragging ? Colors.yellow : Colors.transparent,
            colorBlendMode: BlendMode.color,
            fit: BoxFit.contain,
          ),
          isDragging
              ? Container()
              : Text(
            "第$item位",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xa6000000),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
