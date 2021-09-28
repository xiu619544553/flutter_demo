import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/*
pubspec.yaml
*/

void main() {

  // Future异步任务实现，是通过 Timer实现的。

  // 1、Future和箭头语法
  // isolateDemo1();

  // 2、主 Isolate
  // isolateDemo2();

  // 3、子 Isolate
  // isolateDemo3();

  // 关于 then，它在Future任务执行完毕之后，立即执行，可以看做是一个任务执行。

  // 4、面试题：then是否可以添加到微任务
  // isolateDemo4();

  // 5、Timer
  // timerDemo();

  // 6、dio - get请求
  // dioGetDemo();

  // 7、dio - 下载文件
  dioDownloadDemo();
}

/// 1、Future和箭头语法
void isolateDemo1() {
  Future(() => compute(func1, 1)).then((value) => print('1结束了'));
  Future(() => compute(func1, 1)).then((value) => print('2结束了'));
  Future(() => compute(func1, 1)).then((value) => print('3结束了'));
  Future(() => compute(func1, 1)).then((value) => print('4结束了'));
  Future(() => compute(func1, 1)).then((value) => print('5结束了'));

  // 输出结果是无序的
}

void func1(int count) {
  print(Isolate.current.debugName);
}

/// 2、主 Isolate
void isolateDemo2() {
  loadData().then((value) => print('1结束了'));
  loadData().then((value) => print('2结束了'));
  loadData().then((value) => print('3结束了'));
  loadData().then((value) => print('4结束了'));
  loadData().then((value) => print('5结束了'));

  /*
输出结果是有序的：
flutter: 1结束了
flutter: 2结束了
flutter: 3结束了
flutter: 4结束了
flutter: 5结束了
flutter: _spawn
flutter: _spawn
flutter: _spawn
flutter: _spawn
flutter: _spawn
  */
}

Future loadData() {
  // 此时 Future是 主Isolate的 Event Loop 中，按照添加的 顺序执行
  return Future(() {
    compute(func1, 1);
  });
}

/// 3、子Isolaate
void isolateDemo3() {
  loadData().then((value) => print('1结束了'));
  loadData().then((value) => print('2结束了'));
  loadData().then((value) => print('3结束了'));
  loadData().then((value) => print('4结束了'));
  loadData().then((value) => print('5结束了'));

  // 返回结果是无序的
}

Future loadData3() {
  // 此时 Future是 子Isolate的 Event Loop 中，执行是乱序的。then 已经回到了主Isolate中。
  return Future(() {
    // 返回的是compute的Future，那么这个任务在子Isolate的事件队列中。
    return compute(func1, 1);
  });
}

/// 4、
void isolateDemo4() {
  Future f = Future(() {
    print('A异步任务');
    scheduleMicrotask(() => print('B微任务'));
  });

  f.then((value) => print('C异步任务结束'));
  print('D主任务');

  /*
  执行顺序：D、A、C、B

  D 在主Isolate中，优先执行（外部代码优先级最高）；
  A 在子Isolate中（Future被添加到Event Loop事件循环中，当前事件循环中还没有微任务队列，所以执行完A，立即执行C）
  最后在检测事件循环，检测到B微任务，然后执行；

  * */
}

/// 5、Timer
void timerDemo() {
  Timer.run(() {
    print('异步任务');
  });

  print('主Isolate');
}

/// 6、dio - get请求
void dioGetDemo() {
  // dioGetDemo() async
  // try {
  //   var response = await Dio().get('http://rap2api.taobao.org/app/mock/291253/api/chat/list');
  //   print(response);
  // } catch (e) {
  //   print(e);
  // }
  
  var dio = Dio();
  dio.get('http://rap2api.taobao.org/app/mock/291253/api/chat/list').then((value) {
    print(value.data.toString());
  }).catchError((e) {
    print(e);
  });
}


String savePath = '/Users/hello/Desktop/腾讯课堂.app';
String downloadUrl = 'https://edu-files-1251502357.cos.ap-shanghai.myqcloud.com/CourseTeacher_2.8.1.13_DailyBuild.dmg';

/// 7、dio - 下载文件
void dioDownloadDemo() {
  // 示例：下载腾讯课堂客户端
  // https://edu-files-1251502357.cos.ap-shanghai.myqcloud.com/CourseTeacher_2.8.1.13_DailyBuild.dmg

  // dio 路径中不存在路径，会自动创建文件夹，`/Users/hello/Desktop/test/腾讯课堂.app`，比如桌面不存在 test文件夹，dio会自动创建

  // demo1 - savePath 是 String
  // dioDownloadDemo1();

  // demo2 - savePath 是 Function
  // dioDownloadDemo2();

  // demo3 - 下载到沙盒中
  dioDownloadDemo3();
}

// demo1 - savePath 是 String
void dioDownloadDemo1() {
  var dio = Dio();
  dio.download(
    downloadUrl,
    savePath,
    onReceiveProgress: progressCallback,
  ).then((value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() => print('下载结束'));
}

// demo2 - savePath 是 Function
void dioDownloadDemo2() {
  // savePath可以使 Function
  var dio = Dio();
  dio.download(
    downloadUrl, (header) {
      return savePath;
    },
    onReceiveProgress: progressCallback,
  ).then((value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() => print('下载结束'));
}

// demo3 - 下载到沙盒中
void dioDownloadDemo3() {

  // Dart文件写入支持不友好。建议使用第三方。
  // 获取沙河路径
  String sandboxPath = Directory.systemTemp.path;
  String downloadPath = sandboxPath + '/腾讯课堂.app';
  print(sandboxPath);

  var dio = Dio();
  dio.download(
    downloadUrl,
    downloadPath,
    onReceiveProgress: progressCallback,
  ).then((value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() => print('下载结束'));
}

// 下载进度回调
void progressCallback(int count, int total) {
  // dio 设置了，如果事先不知道响应体的大小，则total = -1
  if (total == -1) {
    print('count: $count');
  } else {
    // toStringAsFixed指定小数点几位
    print((count / total * 100).toStringAsFixed(0) + '%');
  }
}

