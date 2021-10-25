import 'package:flutter/material.dart';


/// NestedScrollView 用法
/// 实现：滚动隐藏AppBar

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({Key? key}) : super(key: key);

  @override
  _NestedScrollViewDemoState createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo> {
  List<Widget> _headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text('NestedScrollView'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: _headerSliverBuilder,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            color: Colors.primaries[index % Colors.primaries.length],
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
        itemCount: 120,
      ),
    );
  }
}
