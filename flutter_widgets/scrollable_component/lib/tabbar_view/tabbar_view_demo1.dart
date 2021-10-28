import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_component/page_view/page_view_demo1.dart';

class TabBarViewDemo1 extends StatefulWidget {

  final int? num;

  const TabBarViewDemo1({Key? key, this.num}) : super(key: key);

  @override
  _TabBarViewDemo1State createState() => _TabBarViewDemo1State();
}

class _TabBarViewDemo1State extends State<TabBarViewDemo1> {
  @override
  Widget build(BuildContext context) {
    return (widget.num == 0) ? TabBarExample1() : TabBarExample2();
  }
}

/// TabBar 通常位于 AppBar 的底部，它也可以接收一个 TabController ，如果需要和 TabBarView 联动， TabBar 和 TabBarView 使用同一个 TabController 即可，
/// 注意，联动时 TabBar 和 TabBarView 的孩子数量需要一致。

/// 例子一
class TabBarExample1 extends StatefulWidget {
  const TabBarExample1({Key? key}) : super(key: key);

  @override
  _TabBarExample1State createState() => _TabBarExample1State();
}

class _TabBarExample1State extends State<TabBarExample1>
    with SingleTickerProviderStateMixin {
  late TabController _tableController;
  List<String> tabs = ["昨天", "今天", "明天"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tableController = TabController(length: tabs.length, vsync: this);
  }

  List<Widget> _createTabBarChildren() {
    return tabs.map((e) {
      return KeepAliveWrapper(
          child: Container(
        alignment: Alignment.center,
        child: Text(
          e,
          textScaleFactor: 5,
        ),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TabBar 的使用"),
        bottom: TabBar(
          controller: _tableController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          indicatorSize: TabBarIndicatorSize.label,  // 指示器长度，有两个可选值，一个tab的长度，一个是label长度
          indicatorColor: Colors.red,
          indicatorWeight: 10.0,
        ),
      ),
      body: TabBarView(
        /// 与 Tab 共用一个 TabController，可以实现与 Tab 联动
        controller: _tableController,
        children: _createTabBarChildren(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    /// 由于 TabController 中会执行动画，持有一些资源，所以我们在页面销毁时必须得释放资源（dispose）
    _tableController.dispose();
  }
}


/// 例子2
/// 综上，我们发现创建 TabController 的过程还是比较复杂，
/// 实战中，如果需要 TabBar 和 TabBarView 联动，通常会创建一个 DefaultTabController 作为它们共同的父级组件，
/// 这样它们在执行时就会从组件树向上查找，都会使用我们指定的这个 DefaultTabController。我们修改后的实现如下：

/// 可以看到我们无需去手动管理 Controller 的生命周期，也不需要提供 SingleTickerProviderStateMixin，
/// 同时也没有其它的状态需要管理，也就不需要用 StatefulWidget 了，这样简单很多。

/// #页面缓存
/// 因为TabBarView 内部封装了 PageView，如果要缓存页面，可以参考 PageView 一节中关于页面缓存的介绍。

class TabBarExample2 extends StatefulWidget {
  const TabBarExample2({Key? key}) : super(key: key);

  @override
  _TabBarExample2State createState() => _TabBarExample2State();
}

class _TabBarExample2State extends State<TabBarExample2> {

  List<String> tabs = ["昨天", "今天", "明天"];

  List<Widget> _createTabBarChildren() {
    return tabs.map((e) {
      return KeepAliveWrapper(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 5,
            ),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("DefaultTabController 实现 TabBarView 和 TabBar 联动"),
            bottom: TabBar(tabs: tabs.map((e) => Tab(text: e)).toList()),
          ),
          body: TabBarView(children: _createTabBarChildren()),
        )
    );
  }
}











