

import 'package:flutter/material.dart';


/// NestedScrollView 与 TabBar 配合使用
class NestedScrollViewTabbarDemo extends StatefulWidget {
  const NestedScrollViewTabbarDemo({Key? key}) : super(key: key);

  @override
  _NestedScrollViewTabbarDemoState createState() => _NestedScrollViewTabbarDemoState();
}

class _NestedScrollViewTabbarDemoState extends State<NestedScrollViewTabbarDemo> with TickerProviderStateMixin {

  ///监听tab切换的控制器
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      // _answerController.changeSelect(_tabController.index);
    });

  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 230.0,
            pinned: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: PageView(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this._tabController,
                tabs: <Widget>[
                  Tab(text: '资讯'),
                  Tab(text: '技术'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[
          RefreshIndicator(
            onRefresh: (){
              print(('onRefresh'));

              return Future(() {});
            },
            child: Center(
              child: Text(
                'tabbarView'
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar? child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child!.preferredSize.height;

  @override
  double get minExtent => this.child!.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}