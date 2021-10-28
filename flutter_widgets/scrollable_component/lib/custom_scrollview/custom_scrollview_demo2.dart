

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 参考
/// https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver

class CustomScrollViewDemo2 extends StatefulWidget {
  const CustomScrollViewDemo2({Key? key}) : super(key: key);

  @override
  _CustomScrollViewDemo2State createState() => _CustomScrollViewDemo2State();
}



/// 代码分三部分
///
/// 1、头部 SliverAppBar
/// SliverAppBar 对应 AppBar 两者不同之处在于SliverAppBar可以集成到CustomScrollView。
/// SliverAppBar 可以结合 FlexibleSpaceBar 实现Material Design中头部伸缩的模型，
///
/// 2、中间的SliverGrid
/// 它用SliverPadding 包裹以给 SliverGrid 添加补白。SliverGrid是一个两列，宽高比为4的网格，它有20个子组件。
///
/// 3、SliverFixedExtentList
/// 底部SliverFixedExtentList：它是一个所有子元素高度都为50像素的列表。
class _CustomScrollViewDemo2State extends State<CustomScrollViewDemo2> {
  
  @override
  Widget build(BuildContext context) {
    return // 因为本路由没有使用 Scaffold，为了让子级Widget(如Text)使用
// Material Design 默认的样式风格,我们使用 Material 作为本路由的根。
      Material(
        child: CustomScrollView(
          slivers: <Widget>[
            // AppBar，包含一个导航栏.
            SliverAppBar(
              pinned: true, // 滑动到顶端时会固定住
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Demo'),
                background: Image(image: AssetImage("images/sand.png"), fit: BoxFit.cover,),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverGrid(
                //Grid
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //Grid按两列显示
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0, // item 的宽高比
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    //创建子widget
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('grid item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      );;
  }
}
