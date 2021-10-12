
import 'package:flutter/material.dart';

/// Stateful 尽可能在树的末端

/// 父控件是 stateless，子控件是 stateful。如何在父控件修改子控件的状态
/// 两种方案
/// 1、子控件添加一个回调，将修改的值通过回调传给子控件
/// 2、通过 GlobalKey


/// GlobalKey 的使用

class GlobalKeyDemo extends StatelessWidget {

  // 创建GlobalKey
  final GlobalKey<_ChildPageState> _globalKey = GlobalKey();

  // 构造函数
  GlobalKeyDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlobalKey'),
      ),
      body: ChildPage(
        key: _globalKey,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_globalKey.currentState != null) {
            _globalKey.currentState!.count ++;
            _globalKey.currentState!.setState(() {});
          }
        },
      ),
    );
  }
}

class ChildPage extends StatefulWidget {
  const ChildPage({Key? key}) : super(key: key);

  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {

  int count = 0;
  String data = 'hello';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text(count.toString()),
          Text(data),
        ],
      ),
    );
  }
}

