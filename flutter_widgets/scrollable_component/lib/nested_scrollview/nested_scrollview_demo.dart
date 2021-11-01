import 'package:flutter/material.dart';


/// 参考：https://book.flutterchina.club/chapter6/nestedscrollview.html#_6-12-3-sliverappbar
/// NestedScrollView、SliverAppBar

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({Key? key}) : super(key: key);

  @override
  _NestedScrollViewDemoState createState() => _NestedScrollViewDemoState();
}

/// 使用 NestedScrollView 有两点需要注意：
///
/// 1、要确认内部的可滚动组件（body）的 physics 是否需要设置为 ClampingScrollPhysics。
/// 比如下面的示例运行在 iOS 中时，ListView 如果没有设置为 ClampingScrollPhysics，则用户快速滑动到顶部时，会执行一个弹性效果，
/// 此时 ListView 就会与 header 显得割裂（滑动效果不统一），所以需要设置。但是，如果 header 中只有一个 SliverAppBar 则不应该加，
/// 因为 SliverAppBar 是固定在顶部的，ListView 滑动到顶部时上面已经没有要继续往下滑动的元素了，所以此时出现弹性效果是符合预期的。
///
/// 2、内部的可滚动组件（body的）不能设置 controller 和 primary，这是因为 NestedScrollView 的协调器中已经指定了它的 controller，如果重新设定则协调器将会失效。



/// SliverAppBar
/// 因为它最常见的使用场景是在作为 NestedScrollView 的 header
// const SliverAppBar({
// this.collapsedHeight, // 收缩起来的高度
// this.expandedHeight,// 展开时的高度
// this.pinned = false, // 是否固定
// this.floating = false, //是否漂浮
// this.snap = false, // 当漂浮时，此参数才有效
// bool forceElevated //导航栏下面是否一直显示阴影
// ...
// })


class _NestedScrollViewDemoState extends State<NestedScrollViewDemo> {
  List<Widget> _headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text('嵌套ListView'),
        pinned: true, // 固定在顶部
        forceElevated: innerBoxIsScrolled, // 导航栏下面是否一直显示阴影
      ),
      buildSliverList(5), // 构建一个 sliverList
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      /// NestedScrollView 它的功能时组合（协调）两个可滚动组件
      child: NestedScrollView(

        /// NestedScrollView 在逻辑上将可滚动组件分为了 header 和 body 两部分，
        ///
        /// header 部分我们可以认为是外部可滚动组件（outer scroll view），可以认为这个可滚动组件就是 CustomScrollView ，所以它只能接收 Sliver，
        /// 我们通过headerSliverBuilder 来构建一个 Sliver 列表给外部的可滚动组件
        headerSliverBuilder: _headerSliverBuilder,

        /// body 部分可以接收任意的可滚动组件，该可滚动组件称为内部可滚动组件 （inner scroll view）。
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(),
          itemCount: 30,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ),
      ),
    );
  }

  // 构建固定高度的SliverList，count为列表项属相
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }
}















