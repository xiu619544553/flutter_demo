
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePictureDemo extends StatefulWidget {
  const ChangePictureDemo({Key? key}) : super(key: key);

  @override
  _ChangePictureDemoState createState() => _ChangePictureDemoState();
}

class _ChangePictureDemoState extends State<ChangePictureDemo> {

  /// Flutter中有三种Channel
  // MethodChannel
  // MessageChannel
  // EventChannel


  /// flutter与原生交互，需要一个管道 channel
  /// 可以传bundle，也可以传页面
  MethodChannel _methodChannel = MethodChannel('com.tank');

  // 头像
  File? _avatarFile;

  ImageProvider _avatarImage() {
    if (_avatarFile == null) {
      return AssetImage('images/wc_avatar.png');
    } else {
      return FileImage(_avatarFile!);
    }
  }

  // 初始化方法
  @override
  void initState() {
    super.initState();

    // 监听回调
    _methodChannel.setMethodCallHandler((call) {

      print('调用的方法是：' + call.method);

      if (call.method == 'imagePath') {
        // file:// 是无效字符，要截取掉
        String imagePath = call.arguments.toString().substring(7);
        print('Flutter监听消息：${imagePath}');

        setState(() {
          _avatarFile = File(imagePath);
        });
      }
      return Future(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: GestureDetector(
        onTap: () {
          print('切换头像');
          // 发送一个 changePicture 消息
          _methodChannel.invokeMethod('changePicture');
        },
        child: Row(
          children: [
            Text(
              '点击黑色icon',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Image(
              image: _avatarImage(),
            ),
          ],
        ),
      ),
    );
  }
}


