import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/pages/chat/search_page.dart';

class ChatSearchCell extends StatelessWidget {
  const ChatSearchCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('点击搜索cell');

        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => SearchPage()));
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
