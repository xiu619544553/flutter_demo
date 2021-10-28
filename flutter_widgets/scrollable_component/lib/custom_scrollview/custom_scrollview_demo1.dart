import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 参考
/// https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-1-customscrollview
/// https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver

class CustomScrollViewDemo1 extends StatefulWidget {
  const CustomScrollViewDemo1({Key? key}) : super(key: key);

  @override
  _CustomScrollViewDemo1State createState() => _CustomScrollViewDemo1State();
}

class _CustomScrollViewDemo1State extends State<CustomScrollViewDemo1> {
  Widget buildTwoSliverList() {
    // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
    // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
    // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    // 使用
    return CustomScrollView(
      slivers: [
        listView,
        listView,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomScrollView 提供公共的 Scrollable 和 ViewPort"),
      ),
      body: buildTwoSliverList(),
    );
  }
}

/// SliverToBoxAdapter。
/// 一个适配器，可以将 RenderBox 适配为 Sliver
class CustomScrollViewDemo3 extends StatefulWidget {
  const CustomScrollViewDemo3({Key? key}) : super(key: key);

  @override
  _CustomScrollViewDemo3State createState() => _CustomScrollViewDemo3State();
}

class _CustomScrollViewDemo3State extends State<CustomScrollViewDemo3> {
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SliverToBoxAdapter 适配器"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView(
                children: [
                  Container(
                    child: Center(
                      child: Text("1", textScaleFactor: 5),
                    ),
                    color: Colors.red,
                  ),
                  Container(
                    child: Center(
                      child: Text("2", textScaleFactor: 5),
                    ),
                    color: Colors.green,
                  )
                ],
              ),
            ),
          ),
          listView,
        ],
      ),
    );
  }
}


/// SliverPersistentHeader
/// SliverPersistentHeader 的功能是当滑动到 CustomScrollView 的顶部时，可以将组件固定在顶部。

/// 需要注意， Flutter 中设计 SliverPersistentHeader 组件的初衷是为了实现 SliverAppBar，所以它的一些属性和回调在SliverAppBar 中才会用到。
/// 因此，如果我们要直接使用 SliverPersistentHeader，看到它的一些配置和参数会感到疑惑，使用起来会感觉有心智成本，
/// 为此，笔者会在下面介绍中指出哪些是需要我们重点关注的，哪些是可以忽略的，
/// 最后为了便于使用，我们会封装一个SliverHeaderDelegate ，通过它我们只需要配置我们关注的属性即可。


// const SliverPersistentHeader({
// Key? key,
// // 构造 header 组件的委托
// required SliverPersistentHeaderDelegate delegate,
// this.pinned = false, // header 滑动到可视区域顶部时是否固定在顶部
// this.floating = false, // 正文部分介绍
// })

/// floating 的做用是：pinned 为 false 时 ，则 header 可以滑出可视区域（CustomScrollView 的 Viewport）（不会固定到顶部），
/// 当用户再次向下滑动时，此时不管 header 已经被滑出了多远，它都会立即出现在可视区域顶部并固定住，
/// 直到继续下滑到 header 在列表中原来的位置时，header 才会重新回到原来的位置（不再固定在顶部）。


typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {


    // //测试代码：如果子组件设置了key，则打印日志
    // if (child.key != null) {
    //   print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
    // }

    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(
      child: builder(context, shrinkOffset, overlapsContent),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}


/// SliverPersistentHeaderDelegate
class PersistentHeaderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SliverPersistenHeaderDelegate"),
      ),
      body: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(//有最大和最小高度
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          buildSliverList(),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight( //固定高度
              height: 50,
              child: buildHeader(2),
            ),
          ),
          buildSliverList(20),
        ],
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

  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }
}

