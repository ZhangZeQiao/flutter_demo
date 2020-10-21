import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FutureTestPage extends StatefulWidget {
  FutureTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _FutureTestPageState();
}

class _FutureTestPageState extends State<FutureTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: RaisedButton(
        child: Text('测试'),
        onPressed: _isolateTest,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // -------------------------------------------------------
  // -------------------------------------------------------

  void _demo() {
    print("initState:${DateTime.now()}");
    _loadUserInfo();
    print("initState:${DateTime.now()}");
  }

  Future _getUserInfo() async {
    await Future.delayed(Duration(seconds: 3));
    return '我是用户';
  }

  Future _loadUserInfo() async {
    /*
    I/flutter ( 5255): initState:2020-10-20 09:39:55.798376
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:39:55.804968
    I/flutter ( 5255): initState:2020-10-20 09:39:55.809743
    I/flutter ( 5255): 我是用户
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:39:58.814776
    */
    /*print('_loadUserInfo:${new DateTime.now()}');
    // TODO await 会阻塞流程，等待紧跟着的的 Future 执行完毕之后，再执行下一条语句
    print(await _getUserInfo());
    print('_loadUserInfo:${new DateTime.now()}');*/

    /*
    I/flutter ( 5255): initState:2020-10-20 09:38:39.822147
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:38:39.830940
    I/flutter ( 5255): _loadUserInfo:2020-10-20 09:38:39.837982
    I/flutter ( 5255): initState:2020-10-20 09:38:39.838884
    I/flutter ( 5255): 我是用户
    */
    print('_loadUserInfo:${DateTime.now()}');
    // TODO Future.then 这个 api，那么就不会等待，直接执行下面的语句，等 Future 执行完了，再调用 then 这个方法
    _getUserInfo().then((info) {
      print(info);
    });
    print('_loadUserInfo:${DateTime.now()}');
  }

  // -------------------------------------------------------
  // -------------------------------------------------------

  // https://www.jianshu.com/p/d03cc2e05693

  void _eventLoop() {
    /*
    TODO 事件驱动
     单线程+事件循环【这是相对于多线程的另一种异步方式】
     程序大部分时间都是处于空闲的状态的，有空闲就可以去循环处理事件
     （这样一理解，单独看"Android主线程+Handler机制"也是一种"单线程+事件循环"模式，只是Android有多线程向主线程push msg）
     https://zhuanlan.zhihu.com/p/83781258
    Dart中的 Event Loop:
    循环中有两个队列。一个是微任务队列（MicroTask queue），一个是事件队列(Event queue)。
    Dart的事件循环的运行遵循以下规则：
    首先处理所有微任务队列里的微任务。处理完所有微任务以后。从事件队列里取1个事件进行处理。回到微任务队列继续循环。
    */
    /*
    举个简单的例子，请问下面这段代码是否会输出想要的字符串?
    答案是不会，因为在始终会有一个foo存在于微任务队列。导致Event Loop没有机会去处理事件队列。
    */
    Timer.run(() {
      print('---haha---');
    });
    foo() {
      // print('+++haha+++');
      scheduleMicrotask(foo);
    }

    foo();

    /*
    TODO 那么在Dart中如何让你的代码异步执行呢？很简单，把要异步执行的代码放在 微任务队列 或者 事件队列里 就行了。
    scheduleMicrotask((){
        print('a microtask');
    });
    Timer.run((){
        print('a event');
    });
    */
  }

  void _futureApi() {
    // 创建一个立刻在事件队列里运行的Future:
    Future(() {
      print('立刻在Event queue中运行的Future');
    });

    // 创建一个延时1秒在事件队列里运行的Future:
    Future.delayed(
        Duration(seconds: 1), () => print('1秒后在Event queue中运行的Future'));

    // 创建一个在微任务队列里运行的Future: TODO 优先执行
    Future.microtask(() => print('在Microtask queue里运行的Future'));

    // 创建一个同步运行的Future：TODO ??? 有何用处
    Future.sync(() => print('同步运行的Future'));

    // 其他
    Future(() => print('task'))
        // 解决了"回调地狱"的问题
        // 通过then串起来的那些回调函数在Future完成的时候会被立即执 行，也就是说它们是同步执行，而不是被调度异步执行。
        .then((_) => print('callback1'))
        .then((_) => print('callback2'))
        // 上面这个Future执行时直接抛出一个异常，这个异常会被catchError捕捉到
        .catchError((error) => print('$error'))
        // 无论这个Future是正常执行完毕还是抛出异常，whenComplete都一定会被执行
        .whenComplete(() => print('whenComplete'));
  }

  /*
  通过以上那些Future构造函数生成的Future对象其实控制权不在你这里。
  它什么时候执行完毕只能等系统调度了。
  你只能被动的等待Future执行完毕然后调用你设置的回调。
  如果你想手动控制某个Future怎么办呢？请使用Completer。
  */

  /*
  Future相对于调度回调函数来说，缓减了回调地狱的问题。
  但是如果Future要串起来的的东西比较多的话，代码还是会 可读性 比较差。
  特别是各种Future嵌套起来，是比较烧脑的。
  所以能不能更给力一点呢？可以的！JavaScript有 async/await，Dart也有。
  async和await是什么？它们是Dart语言的关键字，有了这两个关键字，可以让你用同步代码的形式写出异步代码。
  */
  // TODO async、await本质上就是协程的一种语法糖
  void _asyncAndAwait() {
    bar() async {
      print("bar E");
      return "hello";
    }

    foo1() async {
      print('foo1 E');
      String value = await bar();
      /* TODO
          await并不像字面意义上程序运行到这里就停下来啥也不干等待Future完成。
          而是立刻结束当前函数的执行并返回一个Future。
          函数内剩余代码通过调度异步执行。
      */
      // async 函数中可以出现多个await,每遇见一个就返回一个Future, 实际结果类似于用then串起来的回调。
      print('foo1 X $value');
    }

    foo2() {
      print('foo2 E');
      return Future(bar).then((value) => print('foo2 X $value'));
    }

    // TODO foo1、foo2效果等同
    foo1();
    foo2();

    // 使用async和await还有一个好处是我们可以用和同步代码相同的try/catch机制来做异常处理。
    foo3() async {
      try {
        print('foo E');
        var value = await bar();
        print('foo X $value');
      } catch (e) {
        // TODO 同步执行代码中的异常和异步执行代码的异常都会被捕获
      } finally {}
    }
    // TODO 在日常使用场景中，我们通常利用async，await来异步处理 IO，网络请求，以及Flutter中的Platform channels通信等耗时操作。
  }

  // -------------------------------------------------------
  // -------------------------------------------------------

  /*
  TODO https://www.jianshu.com/p/54da18ed1a9e
   Flutter默认是单线程任务处理的，如果不开启新的线程，任务默认在主线程中处理。
   应用程序启动后，开始执行main函数并运行main isolate。
   每个isolate包含一个事件循环（event loop事件循环）以及两个事件队列（event queue和microtask queue事件队列）。
   event queue：负责处理I/O事件、绘制事件、手势事件、接收其他isolate消息等外部事件。
   microtask queue：可以自己向isolate内部添加事件，事件的优先级比event queue高。

  TODO
   和普通Thread不同的是，isolate拥有独立的内存，isolate由线程和独立内存构成。
   正是由于isolate线程之间的内存不共享，所以isolate线程之间并不存在资源抢夺的问题，所以也不需要锁。

  TODO
   Isolate 之间不共享任何资源，只能依靠消息机制通信，因此也就没有资源抢占问题。
   但是，如果只有一个Isolate，那么意味着我们只能永远利用一个线程，这对于多核CPU来说，是一种资源的浪费。
   通过isolate可以很好的利用多核CPU，来进行大量耗时任务的处理。
   如果在开发中，我们有非常多耗时的计算，完全可以自己创建Isolate，在独立的Isolate中完成想要的计算操作。
  */
  void _sleepTest() {
    Future(() {
      print('111-----------');
    });
    Future(() {
      print('222-----------');
      sleep(Duration(seconds: 10));
    });
    Future(() {
      print('333-----------');
    });
    Future(() {
      print('444-----------');
    });
    Future(() {
      print('555-----------');
    });
  }

  /*
  TODO
   事件会入列，如果某一个事件特别耗时，会影响后续事件的执行
   所以，耗时的操作或者计算，可以另开线程来执行
  */
  /*
  TODO https://blog.csdn.net/email_jade/article/details/88941434
   dart中的Isolate比较重量级，UI线程和Isolate中的数据的传输比较复杂，因此flutter为了简化用户代码，在foundation库中封装了一个轻量级compute操作
  */
  void _isolateTest() {
    Future(() {
      print('111-----------+++');
    });
    Future(() {
      print('222-----------+++');
      _getHttp(1);
      /*_getHttp(2);
      _getHttp(3);
      _getHttp(4);
      _getHttp(5);
      _getHttp(6);*/
      // sleep(Duration(seconds: 3));
      print('222++++++++++++++');
    });
    Future(() {
      print('333-----------+++');
    });
    Future(() {
      print('444-----------+++');
    });
    Future(() {
      print('555-----------+++');
    });
  }

  void _getHttp(count) async {
    try {
      // Response response = await Dio().get("https://www.baidu.com");
      // print('+++' + response.toString() + '---$count');
      await Dio().download(
        "https://raw.githubusercontent.com/xuelongqy/flutter_easyrefresh/master/art/pkg/EasyRefresh.apk",
        "/storage/emulated/0/AAAAAA.apk",
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('进度---${receivedBytes / totalBytes}');
        },
      );
      print('+++download+++success');
    } catch (e) {
      print(e);
    }
  }
}
