
import 'package:flutter/material.dart';


/// https://book.flutterchina.club/chapter6/nestedscrollview.html#_6-12-1-nestedscrollview
/// https://book.flutterchina.club/chapter6/nestedscrollview.html#_6-12-3-sliverappbar
/// 6.12 嵌套可滚动组件 NestedScrollView

/// NestedScrollView  嵌套 TabBarView
class NestedTabBarView1 extends StatelessWidget {
  const NestedTabBarView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];
    // 构建 tabBar
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('商城'),
                  /// floating 和 snap组合使用
                  /// floating 为 true 时，SliverAppBar 不会固定到顶部，当用户向上滑动到顶部时，SliverAppBar 也会滑出可视窗口
                  /// 当用户反向滑动时，如果 snap 为 true，此时无论 SliverAppBar 已经滑出屏幕多远，都会立即回到屏幕顶部
                  /// 当用户反向滑动时，如果 snap 为 false，则 SliverAppBar 只有当向下滑到边界时才会重新回到屏幕顶部
                  floating: true,
                  snap: true,
                  /// 导航栏下面是否一直显示阴影
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: buildSliverList(150),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
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