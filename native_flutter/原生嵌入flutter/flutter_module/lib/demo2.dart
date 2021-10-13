

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SecondDemo extends StatefulWidget {
  const SecondDemo({Key? key}) : super(key: key);

  @override
  _SecondDemoState createState() => _SecondDemoState();
}

class _SecondDemoState extends State<SecondDemo> {

  String pageIndex = 'one';

  final MethodChannel _oneChannel = MethodChannel('one_page');
  final MethodChannel _twoChannel = MethodChannel('two_page');
  
  final BasicMessageChannel _messageChannel = BasicMessageChannel('message_channel', StandardMessageCodec());

  @override
  void initState() {
    super.initState();

    // 监听
    _oneChannel.setMethodCallHandler((call) {

      if (call.method == 'one_page') {
        setState(() {
          pageIndex = call.method;
        });
      }

      return Future(() {});
    });

    _twoChannel.setMethodCallHandler((call) {

      if (call.method == 'two_page') {
        setState(() {
          pageIndex = call.method;
        });
      };

      return Future(() {});
    });

    // 持续接收信息
    _messageChannel.setMessageHandler((message) {

      print("收到了来自iOS的信息：${message}");

      return Future(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _rootPage(pageIndex),
    );
  }

  Widget? _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one_page':
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageIndex,
            ),
          ),
          body: ElevatedButton(
            onPressed: () {
              MethodChannel('one_page').invokeMethod('exit');
            },
            child: Container(
              child: Text(
                pageIndex,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              width: 300,
              height: 50,
              color: Colors.grey,
            ),
          ),
        );

      case 'two_page':
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageIndex,
            ),
          ),
          body: ElevatedButton(
            onPressed: () {
              MethodChannel('two_page').invokeMapMethod('exit');
            },
            child: Center(
              child: Container(
                child: Text(
                  pageIndex,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                width: 300,
                height: 50,
                color: Colors.grey,
              ),
            ),
          ),
        );

      case 'message_channel':
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageIndex,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  MethodChannel('two_page').invokeMapMethod('exit');
                },
                child: Center(
                  child: Container(
                    child: Text(
                      '退出当前页面',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),
                    width: 300,
                    height: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                autofocus: true,
                // 设置文字编辑监听控制器
                onChanged: (String text) {
                  print('输入内容：${text}');
                },
                // // 文字内容变化回调
                cursorColor: Colors.green,
                // 设置光标颜色
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 5, bottom: 10), // 设置输入文字左侧间距、底部间距
                  border: InputBorder.none, // 搜索框边框
                  hintText: '请输入内容', // 占位字符
                ),
              ),
            ],
          ),
        );

      default:
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '默认页面',
            ),
          ),
          body: ElevatedButton(
            onPressed: () {
              MethodChannel('default_page').invokeMapMethod('exit');
            },
            child: Center(
              child: Text(
                pageIndex,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        );
    }
  }
}

