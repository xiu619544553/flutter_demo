import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 参考 https://book.flutterchina.club/chapter6/keepalive.html#_6-8-2-keepalivewrapper
/// 如果要实现页面切换和 Tab 布局，我们可以使用 PageView 组件。
/// 需要注意，PageView 是一个非常重要的组件，
/// 因为在移动端开发中很常用，比如大多数 App 都包含 Tab 换页效果、图片轮动以及抖音上下滑页切换视频功能等等，这些都可以通过 PageView 轻松实现。

class PageViewDemo1 extends StatefulWidget {
  const PageViewDemo1({Key? key}) : super(key: key);

  @override
  _PageViewDemo1State createState() => _PageViewDemo1State();
}

class _PageViewDemo1State extends State<PageViewDemo1> {
  @override
  Widget build(BuildContext context) {

    /// 不能保存页面状态
    List<Widget> _children = [];
    for (int i = 0; i < 5; i ++) {
      _children.add(
          Page(text: "$i")
      );
    }

    /// 可以保存页面状态，不是很优雅
    List<Widget> _children2 = [];
    for (int i = 0; i < 5; i ++) {
      _children2.add(
          AlivePage(text: "$i")
      );
    }
    
    /// 保存页面状态，优雅的实现方式
    List<Widget> _children3 = [];
    for (int i = 0; i < 5; i ++) {
      _children3.add(
          Page(text: "$i")
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("PageView 简单使用"),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal, // 水平方向滑动
        allowImplicitScrolling: true, // 置为 true 时就只会缓存前后各一页。false 则不缓存。这是 PageView 的缺陷。如果要缓存功能，请查看 KeepAlive
        /// 通过修改 _children、_children2、_childre3，切换页面
        children: _children3,
      ),
    );
  }
}


/// 不能保存页面状态
class Page extends StatefulWidget {
  final String? text;

  const Page({Key? key, required this.text}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(
      child: Text(
        "${widget.text}",
        textScaleFactor: 5,
      ),
    );
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
    print("${widget.text} - 被销毁了");
  }
}


/// 实现保存yemianzhuangtai。通过混入 AutomaticKeepAliveClientMixin
class AlivePage extends StatefulWidget {

  final String? text;
  const AlivePage({Key? key, required this.text}) : super(key: key);

  @override
  _AlivePageState createState() => _AlivePageState();
}

class _AlivePageState extends State<AlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(
      child: Text(
        "${widget.text}",
        textScaleFactor: 5,
      ),
    );
  }

  /// AutomaticKeepAliveClientMixin
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; // 是否需要缓存

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print("${widget.text} - 被销毁了");
  }
}



/// KeepAliveWrapper
/// 虽然我们可以通过 AutomaticKeepAliveClientMixin 快速的实现页面缓存功能，
/// 但是通过混入的方式实现不是很优雅，因为必须更改 Page 的代码，有侵入性，
/// 这就导致不是很灵活，比如一个组件能同时在列表中和列表外使用，为了在列表中缓存它，则我们必须实现两份。
/// 为了解决这个问题，笔者封装了一个 KeepAliveWrapper 组件，如果哪个列表项需要缓存，只需要使用 KeepAliveWrapper 包裹一下它即可。

class PageWrapper extends StatefulWidget {
  final String? text;
  const PageWrapper({Key? key, required this.text}) : super(key: key);

  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${widget.text}",
        textScaleFactor: 5,
      ),
    );
  }
}


class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if(oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
