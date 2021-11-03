import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 该demo存在的问题
/// 当我们滑动到顶部时，然后反向轻微滑动一点点，这时 SliverAppBar 就会整体回到屏幕顶部，
/// 但这时有一个问题我们发现 SliverAppBar 返回到屏幕后将 0 - 4 这几个列表项遮住了！
/// 而按照正常的交互逻辑，预期是不能遮住的，因为往下滑时，用户就是为了看上面的内容，
/// SliverAppBar 突然整体回到屏幕后正好遮住了上面的内容，这时，用户不得不继续往下再滑动一些距离，这个体验很不好。
class SnapAppBar extends StatelessWidget {
  const SnapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // 实现 snap 效果
            SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              // 展开折叠的区域 通常使用 FlexibleSpaceBar
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: AssetImage("images/wall_paper.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[buildSliverList(100)],
          );
        }),
      ),
    );
  }

  Widget buildSliverList(int num) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text("$index")),
            childCount: num),
        itemExtent: 50);
  }
}


/// 解决上述Demo中出现的问题
class SnapAppBar2 extends StatelessWidget {
  const SnapAppBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image(
                    image: AssetImage("images/wall_paper.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              buildSliverList(100)
            ],
          );
        }),
      ),
    );
  }

  Widget buildSliverList(int num) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text("$index")),
            childCount: num),
        itemExtent: 50);
  }
}





