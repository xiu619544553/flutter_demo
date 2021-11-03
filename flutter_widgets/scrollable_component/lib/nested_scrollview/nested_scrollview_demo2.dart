import 'package:flutter/material.dart';

/// NestedScrollView、SliverAppBar 展开与折叠
class NestedScrollViewDemo2 extends StatefulWidget {
  const NestedScrollViewDemo2({Key? key}) : super(key: key);

  @override
  _NestedScrollViewDemo2State createState() => _NestedScrollViewDemo2State();
}

class _NestedScrollViewDemo2State extends State<NestedScrollViewDemo2> {
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
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 230.0,
            /// appBar是否置顶 是否固定在顶部 为true是固定，为false是不固定可滑出屏幕
            pinned: true,
            /// 展开折叠的区域 通常使用 FlexibleSpaceBar
            flexibleSpace: FlexibleSpaceBar(
              title: Text('复仇者联盟'),
              background: Image.network(
                'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
          )
        ];
      },
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
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
        itemCount: 20,
      ),
    );
  }
}
