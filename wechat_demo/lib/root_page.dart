
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/chat_page.dart';
import 'package:wechat_demo/pages/discover/discover_page.dart';
import 'package:wechat_demo/pages/friends/friend_page.dart';
import 'package:wechat_demo/pages/mine/mine_page.dart';


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _currentIndex = 0;

  /// 小部件_pages只要不在渲染树中，小部件就会被释放掉。
  /// 只要是不显示在渲染树上的小部件，这个小部件就会从渲染树中销毁。当进入页面时，会拿到小部件重新渲染。
  /// `body: _pages[_currentIndex]` 不能保存页面状态分析：切换tab，小部件会被从内存中拿出来放到渲染树中，重新渲染。
  List<Widget> _pages = [
    ChatPage(),
    FriendPage(),
    DiscoverPage(),
    MinePage()
  ];

  /// 如何保存页面状态？使用 PageController，将_page都放到 PageView小部件中，保存PageView小部件的状态，就保存住了_page中小部件的状态
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages, // 注意：⚠️只有数组中的小部件渲染到页面时，才会调用数组中小部件的 init、build方法：懒加载的
        physics: NeverScrollableScrollPhysics(), // 设置PageView滚动方式：设置为不可滚动
        // /// 滚动时，选中滚动位置的tab
        // onPageChanged: (int index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // onTap 是 bottom 的点击事件，会回调当前点击的下标
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          // 切换tab
          _controller.jumpToPage(index);
        },
        selectedFontSize: 12.0,              // 设置 BottomNavigationBarItem 的选中时字体大小
        unselectedFontSize: 12.0,            // 设置 BottomNavigationBarItem 的未选中时字体大小
        currentIndex: _currentIndex,         // 设置选中的下标
        fixedColor: Colors.green,            // 选中颜色
        type: BottomNavigationBarType.fixed, // 定义[BottomNavigationBar]的布局和行为。
        items: [
          BottomNavigationBarItem(
            label: '微信',
            icon: Image.asset('images/tabbar_chat.png', height: 20, width: 20),          // 未选中状态icon
            activeIcon: Image.asset('images/tabbar_chat_hl.png', height: 20, width: 20), // 选中状态的icon
          ),
          BottomNavigationBarItem(
            label: '通讯录',
            icon: Image.asset('images/tabbar_friends.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_friends_hl.png', height: 20, width: 20),
          ),
          BottomNavigationBarItem(
            label: '发现',
            icon: Image.asset('images/tabbar_discover.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_discover_hl.png', height: 20, width: 20),
          ),
          BottomNavigationBarItem(
            label: '我',
            icon: Image.asset('images/tabbar_mine.png', height: 20, width: 20),
            activeIcon: Image.asset('images/tabbar_mine_hl.png', height: 20, width: 20),
          ),
        ],
      ),
    );
  }
}

