
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';


class MainPage extends StatefulWidget {

  String data = '默认值';
  VoidCallback? removeListener;

  MainPage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.data,
        style: TextStyle(
          fontSize: 25,
          color: Colors.red,
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///添加事件响应者,监听native发往flutter端的事件
    widget.removeListener = BoostChannel.instance.addEventListener("MainPageKey", (key, arguments) {

      // 在此处处理你的事件
      var value = arguments['value'] as String;
      setState(() {
        widget.data = value;
      });
      print('key: $key。。。argument: $arguments');
    });
  }

  @override
  void dispose() {

    ///然后在退出的时候（比如dispose中）移除监听者
    widget.removeListener!.call();

    /// 发送消息给native
    BoostChannel.instance.sendEventToNative('FromMainPage', {"returnValue" : "这是从 Flutter回传的值"});
    print("=============页面销毁==========");

    super.dispose();
  }

}

