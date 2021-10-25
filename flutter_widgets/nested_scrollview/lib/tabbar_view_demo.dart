import 'package:flutter/material.dart';

class TabViewDemo extends StatefulWidget {
  @override
  _TabViewDemoState createState() => _TabViewDemoState();
}

class _TabViewDemoState extends State<TabViewDemo>
    with SingleTickerProviderStateMixin {
  /// TabController 用于监听和控制 TabBarView 的页面切换，通常和 TabBar 联动。如果没有指定，则会在组件树中向上查找并使用最近的一个 DefaultTabController 。
  late TabController _tabController;

  /// tabs标题
  List<String> tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            /// 导航栏的标题
            title: Text("App Name"),

            /// TabBar 为 TabBarView 的导航切换部分
            /// TabBar 通常位于 AppBar 的底部，它也可以接收一个 TabController ，如果需要和 TabBarView 联动， TabBar 和 TabBarView 使用同一个 TabController 即可
            /// 注意，联动时 TabBar 和 TabBarView 的孩子数量需要一致。如果没有指定 controller，则会在组件树中向上查找并使用最近的一个 DefaultTabController
            bottom: TabBar(
              controller: _tabController,
              tabs: _createTabs(),
              isScrollable: false,
              // 是否可以滑动
              /// this.indicator 可以设置自己需要的样式的指示器
              indicatorColor: Colors.red,
              // 指示器颜色，默认是高度为2的一条下划线
              indicatorWeight: 4,
              // 指示器高度
              indicatorPadding: EdgeInsets.zero,
              // 指示器padding。
              labelColor: Colors.black,
            ),
          ),
          body: TabBarView(
            /// 如果需要和 TabBarView 联动， TabBar 和 TabBarView 使用同一个 TabController 即可
            controller: _tabController,
            children: _createTabBarChildView(),
          ),
        ));
  }

  /// 构造 tabs。
  List<Widget> _createTabs() {
    return tabs
        .map((e) => Tab(
              text: e,
              icon: Image(
                image: AssetImage('images/sand.png'),
                height: 15,
              ),
            ))
        .toList();
  }

  List<ListView> _createTabBarChildView() {
    return tabs.map((e) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Text("$e  $index"),
          );
        },
        itemCount: tabs.length,
      );
    }).toList();
  }

  @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }
}

/// 关于 Tab
/// const Tab({
//   Key? key,
//   this.text, //文本
//   this.icon, // 图标
//   this.iconMargin = const EdgeInsets.only(bottom: 10.0),
//   this.height,
//   this.child, // 自定义 widget
// })
