import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/pages/chat/chat_data.dart';
import 'package:wechat_demo/pages/chat/search_page.dart';

/// 聊天页面 - 搜索样式cell
class ChatSearchCell extends StatelessWidget {
  final List<Chat> datas;

  const ChatSearchCell({required this.datas});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('点击搜索cell');

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SearchPage(
                  datas: this.datas,
                )));
      },
      child: Container(
        height: 44,
        color: WeChatThemeColor,
        padding: EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center, // 使 children中的控件居中布局
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ), // 白色背景
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/wc_chat_search.png'),
                  width: 15,
                  color: Colors.grey, // 设置图片的颜色
                ),
                Text(
                  '  搜索',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ), // 放大镜和文字
          ],
        ),
      ),
    );
  }
}

/// 搜索页面 - 搜索框
class SearchBar extends StatefulWidget {
  /// 当输入内容发生变化时，回调给外部
  void Function(String str)? onChanged;

  SearchBar({this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // 是否显示取消按钮
  bool _showClear = false;

  /// 监听 TextField 文字输入
  final TextEditingController _textEditingController = TextEditingController();

  /// 文字内容变化回调
  void _textChanged(String text) {
    print(text);

    setState(() {
      _showClear = (text.length > 0);
    });

    // 回调输入内容
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  // 清空按钮
  Widget _clearButton() {
    if (_showClear) {
      return GestureDetector(
        child: Icon(
          Icons.cancel,
          size: 20,
          color: Colors.grey,
        ),
        onTap: () {
          setState(() {
            _textEditingController.clear(); // 清空输入的内容
            _textChanged(''); // clear()不会触发 onChanged，所以需要手动调用
          });
        },
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: WeChatThemeColor,
      child: Column(
        children: [
          SizedBox(height: 40),
          Container(
            height: 44,
            child: Row(
              children: [
                /// 左边白色圆角背景
                Container(
                  width: ScreenWidth(context) - 40 - 5,
                  height: 34,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  // 外部间距
                  padding: EdgeInsets.only(left: 5, right: 5),
                  // 内部间距
                  // 🔍添加间距
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      /// 搜索🔍
                      Image(
                        image: AssetImage('images/wc_chat_search.png'),
                        width: 20,
                        color: Colors.grey, // 设置图片的颜色
                      ),

                      /// 输入框
                      Expanded(
                        flex: 1,
                        child: TextField(
                          autofocus: true,
                          // 设置输入框聚焦状态。进入页面时，键盘默认弹起
                          controller: _textEditingController,
                          // 设置文字编辑监听控制器
                          onChanged: _textChanged,
                          // // 文字内容变化回调
                          cursorColor: Colors.green,
                          // 设置光标颜色
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 5, bottom: 10), // 设置输入文字左侧间距、底部间距
                            border: InputBorder.none, // 搜索框边框
                            hintText: '搜索', // 占位字符
                          ),
                        ),
                      ),

                      /// 取消按钮
                      _clearButton(),
                    ],
                  ),
                ),

                /// 取消按钮
                GestureDetector(
                  child: Text('取消'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
