import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/chat_data.dart';
import 'package:wechat_demo/pages/chat/search_view.dart';

/// 搜索页面

class SearchPage extends StatefulWidget {
  final List<Chat> datas;

  const SearchPage({
    required this.datas,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 搜索结果
  List<Chat> _filterChats = [];

  // 用户搜索内容
  String _searchString = '';

  // 用户名称的普通样式
  TextStyle _normalStyle = TextStyle(fontSize: 16, color: Colors.black);

  // 用户名称的高亮样式
  TextStyle _highlightStyle = TextStyle(fontSize: 16, color: Colors.green);

  // 搜索内容的回调
  void _onChanged(String text) {
    // 每次进来都是重新搜索，清空搜索结果数组
    _filterChats.clear();

    _searchString = text;

    if (text.length > 0) {
      for (int i = 0; i < widget.datas.length; i++) {
        Chat chat = widget.datas[i];
        if (chat.name!.contains(text)) {
          _filterChats.add(chat);
        }
      }
    }

    setState(() {});
  }

  /// 关于 split
  // List<String> strs = 'ahahhahhha'.split('h');
  // for (int i = 0; i < strs.length; i ++) {
  //   print('---${strs[i]}');
  // }
  /*
  输出结果：
flutter: ---a
flutter: ---a
flutter: ---
flutter: ---a
flutter: ---
flutter: ---
flutter: ---a

总结：
  split 截取后，打印会存在空字符串的情况总结
   1.以这个字符串开头，则 strs 第一个会是 空串
   2.以这个字符串结束，则 strs 最后一个是空串
   3.连续出现这个字符串，中间出现空串，会有n+1个与搜索的字符串相同的字符串
  */

  // 用户名称
  Widget _cellTitle(String name) {

    // 富文本子部件数组
    List<TextSpan> spans = [];

    // 分割字符串
    List<String> strs = name.split(_searchString);

    for (int i = 0; i < strs.length; i ++) {

      String str = strs[i];
      if (str  == '' && i < strs.length - 1)  {
        spans.add(
          TextSpan(text: str, style: _highlightStyle),
        );
      } else {
        spans.add(
          TextSpan(text: str, style: _normalStyle),
        );

        if (i < strs.length - 1)  {
          spans.add(
            TextSpan(text: _searchString, style: _highlightStyle),
          );
        }
      }

    }

    return RichText(text: TextSpan(children: spans));
  }

  // 返回cell
  Widget _cellForRow(BuildContext context, int index) {
    Chat model = _filterChats[index];

    return ListTile(
      title: _cellTitle(model.name ?? ''),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          model.message ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(model.image_url ?? ''),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
            onChanged: _onChanged,
          ),
          Expanded(
              flex: 1,
              child: MediaQuery.removePadding(
                  // ListView在 iOS 刘海设备中会默认有一个头，防止刘海遮挡ListView内容，如果不需要，需要开发人员自行去掉
                  context: context,
                  removeTop: true, // 移除ListView的默认头
                  child: ListView.builder(
                    itemBuilder: _cellForRow,
                    itemCount: _filterChats.length,
                  )))
        ],
      ),
    );
  }
}
