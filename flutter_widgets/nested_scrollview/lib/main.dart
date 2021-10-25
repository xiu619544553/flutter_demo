import 'package:flutter/material.dart';
import 'package:nested_scrollview/home_page.dart';
import 'package:nested_scrollview/list_view/list_view_demo.dart';
import 'package:nested_scrollview/nested_scrollview/nested_scrollview_demo2.dart';
import 'package:nested_scrollview/nested_scrollview_tabbar_demo.dart';
import 'package:nested_scrollview/scroll_controller.dart';
import 'package:nested_scrollview/single_child_scrollview_demo.dart';
import 'package:nested_scrollview/tabbar_nestedscrollview.dart';
import 'package:nested_scrollview/tabbar_view_demo.dart';

import 'nested_scrollview/nested_scrollview_demo.dart';

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
    "嵌套可滚动组件 NestedScrollView",
    "SingleChildScrollView",
    "ListView 默认构造函数，适合少量子组件",
    "ListView.builder 按需动态构建列表项",
    "ListView.separated 支持分割组件",
    "ListView 设置固定高度",
    "ListView 无限加载列表",
    "ListView 添加固定列表头",
    "ScrollController 使用",
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
