import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollNotificationDemo extends StatefulWidget {
  const ScrollNotificationDemo({Key? key}) : super(key: key);

  @override
  _ScrollNotificationDemoState createState() => _ScrollNotificationDemoState();
}

class _ScrollNotificationDemoState extends State<ScrollNotificationDemo> {
  String _process = "0%"; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动监听"),
      ),
      body: Scrollbar(
          child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double process = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;

          // 重新构建
          setState(() {
            _process = "${(process * 100).toInt()}%";
          });

          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          return false;
          // return true; //放开此行注释后，进度条将失效
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
              itemCount: 100,
              itemExtent: 50.0,
            ),
            CircleAvatar(
              radius: 30.0,
              child: Text("$_process"),
              backgroundColor: Colors.black54,
            ),
          ],
        ),
      )),
    );
  }
}
