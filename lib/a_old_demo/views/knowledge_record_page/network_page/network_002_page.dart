import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Network002Page extends StatefulWidget {
  final String title;

  Network002Page({Key key, this.title = "Http请求库：Dio"}) : super(key: key);

  @override
  _Network002PageState createState() => _Network002PageState();
}

class _Network002PageState extends State<Network002Page> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          // TODO 函数特殊写法：(context, snapshot)会根据builder类型自动补全参数类型，所以参数类型可写可不写
          builder: (context, AsyncSnapshot snapshot) {
            // 请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              // 请求发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              // 请求成功
              // TODO ListTile：一个固定高度的行，通常包含一些文本，以及一个行前或行尾图标
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                    .toList(),
                /*
                 *
                 * TODO 关于可迭代对象 Iterable<E> 的知识点 -----------------------
                 *
                 * dynamic _aaa;
                 * // class AaaBean<E> extends Iterable<E> ==> AaaBean<Xxx> _aaa = Iterable();
                 * _aaa.map<Widget>((e) => ListTile(title: Text(e["full_name"]))).toList();
                 *
                 * TODO iterable.dart
                 *
                 * collection of values, or "elements", that can be accessed sequentially.
                 *
                 * abstract class Iterable<E> { ... ...  }
                 *
                 * Iterable<E>
                 * - EfficientLengthIterable<T> extends Iterable<T>
                 * -- List<E> implements EfficientLengthIterable<E>
                 * -- Set<E> extends EfficientLengthIterable<E>
                 * -- Queue<E> implements EfficientLengthIterable<E>
                 * -- ... ...
                 *
                 *
                 * Returns a new lazy [Iterable] with elements that are created by calling `f` on each element of this `Iterable` in iteration order.
                 *
                 * This method returns a view of the mapped elements. As long as the
                 * returned [Iterable] is not iterated over, the supplied function [f] will
                 * not be invoked. The transformed elements will not be cached. Iterating
                 * multiple times over the returned [Iterable] will invoke the supplied
                 * function [f] multiple times on the same element.
                 *
                 * Methods on the returned iterable are allowed to omit calling `f` on any element where the result isn't needed.
                 * For example, [elementAt] may call `f` only once.
                 *
                 * Iterable<T> map<T>(T f(E e)) => MappedIterable<E, T>(this, f);
                 *
                 *
                 * Creates a [List] containing the elements of this [Iterable].
                 * The elements are in iteration order.
                 * The list is fixed-length if [growable] is false.
                 *
                 *  List<E> toList({bool growable = true}) {
                 *    return List<E>.from(this, growable: growable);
                 *  }
                 *
                 */
              );
            }
            // 请求未完成时弹出loading
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
