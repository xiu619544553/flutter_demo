import 'package:flutter/material.dart';
import 'package:scrollable_component/custom_scrollview/custom_scrollview_demo1.dart';
import 'package:scrollable_component/custom_scrollview/custom_scrollview_demo2.dart';
import 'package:scrollable_component/home_page.dart';
import 'package:scrollable_component/list_view/animated_list_demo.dart';
import 'package:scrollable_component/list_view/grid_view_demo.dart';
import 'package:scrollable_component/nested_scrollview/appbar_demo1.dart';
import 'package:scrollable_component/nested_scrollview/nested_scrollview_demo.dart';
import 'package:scrollable_component/nested_scrollview/nested_scrollview_demo2.dart';
import 'package:scrollable_component/nested_scrollview_tabbar_demo.dart';
import 'package:scrollable_component/page_view/page_view_demo1.dart';
import 'package:scrollable_component/scrollcontroller/scroll_notification_demo.dart';
import 'package:scrollable_component/scrollcontroller/scrollcontroller_demo.dart';
import 'package:scrollable_component/single_child_scrollview_demo.dart';
import 'package:scrollable_component/tabbar_nestedscrollview.dart';
import 'package:scrollable_component/tabbar_view/tabbar_view_demo1.dart';
import 'package:scrollable_component/tabbar_view_demo.dart';

import 'list_view/list_view_demo.dart';


/// Flutter 中常用的 Sliver
/// https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter小组件'),
        ),
        body: RootPage(),
      ),
    );
  }
}

class RootPage extends StatelessWidget {

  final List<String> _itemTitles = [
    "NestedScrollView 简单使用",
    "NestedScrollView、SliverAppBar 展开折叠",
    "NestedScrollView 与 TabBar 配合使用",
    "MyHomePage",
    "ScrollController 使用",
    "TabBarView",
    "NestedScrollView  嵌套 TabBarView",
    "SingleChildScrollView",
    "ListView 默认构造函数，适合少量子组件",
    "ListView.builder 按需动态构建列表项",
    "ListView.separated 支持分割组件",
    "ListView 设置固定高度",
    "ListView 无限加载列表",
    "ListView 添加固定列表头",
    "ScrollController 使用",
    "ScrollNotification 滚动监听",
    "AnimatedList 可以在列表中插入或删除节点时执行一个动画",
    "GridView 二维网格列表【横轴固定数量】",
    "GridView 二维网格列表【横轴子元素为固定长度】",
    "GridView 二维网格列表【GridView.builder】",
    "PageView 简单使用",
    "TabBarView 通过自定义的 TabController 实现联动",
    "TabBarView 通过 DefaultTabController 实现联动",
    "CustomScrollView 提供公共的 Scrollable 和 ViewPort",
    "CustomScrollView 示例",
    "Material 控件",
    "SliverToBoxAdapter 与 CustomScrollView",
    "SliverPersistentHeaderDelegate",
    "AppBar和NestedScrollView - 示例1",
    "AppBar和NestedScrollView - 示例2",
  ];

  Widget _itemBuilder(BuildContext context, int index) {
    String title = _itemTitles[index];

    return GestureDetector(
      onTap: () {

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {

          if (index == 0) {
            return NestedScrollViewDemo();
          } else if (index == 1) {
            return NestedScrollViewDemo2();
          } else if (index == 2) {
            return NestedScrollViewTabbarDemo();
          } else if (index == 3) {
            return MyHomePage();
          } else if (index == 4) {
            return ScrollControllerTestRoute();
          } else if (index == 5) {
            return TabViewDemo();
          } else if (index == 6) {
            return NestedTabBarView1();
          } else if (index == 7) {
            return SingleChildScrollViewDemo();
          } else if (index == 8) {
            return ListViewDemo(style: 1,);
          } else if (index == 9) {
            return ListViewDemo(style: 2,);
          } else if (index == 10) {
            return ListViewDemo(style: 3,);
          } else if (index == 11) {
            return ListViewDemo(style: 4,);
          } else if (index == 12) {
            return ListViewDemo(style: 5,);
          } else if (index == 13) {
            return ListViewDemo(style: 6,);
          } else if (index == 14) {
            return ScrollControllerTestRoute();
          } else if (index == 15) {
            return ScrollNotificationDemo();
          } else if (index == 16) {
            return AnimatedListRoute();
          } else if (index == 17) {
            return GridViewDemo(num: 0,);
          } else if (index == 18) {
            return GridViewDemo(num: 1,);
          } else if (index == 19) {
            return GridViewDemo(num: 2,);
          } else if (index == 20) {
            return PageViewDemo1();
          } else if (index == 21) {
            return TabBarViewDemo1(num: 0,);
          } else if (index == 22) {
            return TabBarViewDemo1(num: 1,);
          } else if (index == 23) {
            return CustomScrollViewDemo1();
          } else if (index == 24) {
            return CustomScrollViewDemo2();
          } else if (index == 25) {
            return MaterialDemo();
          } else if (index == 26) {
            return CustomScrollViewDemo3();
          } else if (index == 27) {
            return PersistentHeaderRoute();
          } else if (index == 28) {
            return SnapAppBar();
          } else if (index == 29) {
            return SnapAppBar2();
          }

          return Center(
            child: Text('默认页面'),
          );

        }));

      },
      child: Container(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: _itemTitles.length,
        itemExtent: 50.0, // 列表项高度固定时
      ),
    );
  }
}


/// Material 是个没有实际效果的控件，也是个底层的控件,可以用来设置阴影，形状，阴影，颜色，文字格式等等
class MaterialDemo extends StatelessWidget {
  const MaterialDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      shape: new BeveledRectangleBorder(//斜角矩形边框
        side:new BorderSide(
          width: 1.0,
          color: Colors.blueAccent,
          style: BorderStyle.none,
        ),
        borderRadius:new BorderRadius.circular(10.0),
      ),
      child: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Text('斜角矩形边框'),
      ),
    );
  }
}
