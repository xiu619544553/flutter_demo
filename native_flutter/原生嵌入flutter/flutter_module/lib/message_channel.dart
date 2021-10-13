
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageChannelDemo extends StatefulWidget {
  const MessageChannelDemo({Key? key}) : super(key: key);

  @override
  _MessageChannelDemoState createState() => _MessageChannelDemoState();
}

class _MessageChannelDemoState extends State<MessageChannelDemo> {

  final BasicMessageChannel _messageChannel = BasicMessageChannel('message_channel', StandardMessageCodec());

  @override
  void initState() {
    super.initState();

    // 持续接收信息
    _messageChannel.setMessageHandler((message) {
      print("收到了来自iOS的信息：${message}");
      return Future(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _rootPage(),
    );
  }

  Widget? _rootPage() {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BasicMessageChannel 案例',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              MethodChannel('message_channel').invokeMapMethod('exit');
            },
            child: Center(
              child: Container(
                child: Text(
                  '退出当前页',
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
          ElevatedButton(
            onPressed: () {
              _messageChannel.send({"method":"test","ontent":"flutter 中的数据","code":100});
            },
            child: Center(
              child: Container(
                child: Text(
                  '点我点我',
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
        ],
      ),
    );
  }


}
