import 'package:flutter/material.dart';

import 'change_picture.dart';

//不建议Flutter和原生来回切换！
//
//1、性能损耗
//2、内存的泄漏：开启了一个Flutter的页面，FlutterViewController占用的内存不会被全部销毁。

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '更换图片',
          ),
        ),
        body: Center(
          child: ChangePictureDemo(),
        ),
      ),
    );
  }
}
