import 'dart:math';

import 'package:flutter/material.dart';

class KeyDemoPage extends StatefulWidget {
  const KeyDemoPage({Key? key}) : super(key: key);

  @override
  _KeyDemoPageState createState() => _KeyDemoPageState();
}

class _KeyDemoPageState extends State<KeyDemoPage> {


  List<StlItem> items = [
    StlItem('AAAA'),
    StlItem('BBBB'),
    StlItem('CCCC'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeyDemo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            items.removeAt(0);
          });
        },
      ),
    );
  }
}

/// 无状态的正方形
class StlItem extends StatelessWidget {

  final String? title;

  StlItem(this.title);

  final _color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

  // const StlItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(title ?? ''),
    );
  }
}


/// 有状态的正方形
class StfItem extends StatefulWidget {
  // const StfItem({Key? key}) : super(key: key);

  final String? title;

  StfItem(this.title);

  final _color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

  @override
  _StfItemState createState() => _StfItemState();
}

class _StfItemState extends State<StfItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: widget._color,
      child: Text(widget.title ?? ''),
    );
  }
}
