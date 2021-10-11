import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:http/http.dart' as http;
import 'package:wechat_demo/pages/chat/chat_data.dart';
import 'package:wechat_demo/pages/chat/search_view.dart';
import 'package:wechat_demo/tools/http_manager.dart';


/*
import 'package:http/http.dart' as http;

as 时为了解决方法名冲突的问题，通过重命名.方法名 调用。
*/

/*
hide 隐藏某个不要导入的方法
import 'package:http/http.dart' as http hide get;

show 只导入指定的方法
*/

/// 如何使 StatefulWidget 类保存即有状态。当我们切换tab，在切换回来后，是当前叶敏保存状态
/*
概念：
  混入 Mixins
使用 with来混入一个或多个Mixin

前置条件：当前小部件在渲染树中
1、遵守 with AutomaticKeepAliveClientMixin
2、重写实现 get 方法
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
3、当前类 build方法调用父类 super.build(context);

*/

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 构造 PopupMenuItem
  Widget _buildPopupMenuItem(String imageAsset, String title) {
    return Row(
      children: [
        Image(
          image: AssetImage(imageAsset),
          width: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    );
  }

  // 聊天数据模型
  List<Chat> _chatDatas = [];

  // 初始化
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 获取聊天数据
    // 通过 .then，来获取 Future 的数据
    getChatDatas().then((value) => {
      setState(() {
        _chatDatas = value;
      })
    })
        .catchError((e) => print('请求错误: ${e}'))
        .whenComplete(() => print('请求完毕'))
        .timeout(Duration(seconds: 10)).catchError((e) => print('超时输出：${e}'));
    // 即使网络超时，接口还是会继续请求的。如果要处理超时页面，可以设置布尔值来控制页面显示状态。
  }

  /// 网络请求耗时，异步执行（在函数名称后添加 async）
  /// 返回值类型 Future<List<Chat>>：表示有可能返回值是 List<Chat>，也有可能没有值，也有可能有错误
  Future<List<Chat>> getChatDatas() async {
    // await 告知该段代码要异步执行
    // http.get 方法的返回值是 Future<Response>，表示该返回值可能有值，也可能没有值，有肯能有错误。
    // 只要是 Future 返回类型，我们可以使用 then 处理返回返回结果。

    /// http 网络库实现网络请求。接口返回 json数据，数据转换流程是：json ==> Map ==> Model
    // var chatListUrl =
    //     Uri.parse('http://rap2api.taobao.org/app/mock/291253/api/chat/list');
    // var response = await http.get(chatListUrl);
    // // print('Response status: ${response.statusCode}');
    // // print('Response body: ${response.body}');
    //
    // if (response.statusCode == 200) {
    //   // json 转 Map
    //   var responseBody = json.decode(response.body);
    //
    //   // Map 转 Model。
    //   // .map 相当于遍历 map。item就是json，在回调中将 item 转换为 Chat模型。
    //   List<Chat> chatList = responseBody['chat_list'].map<Chat>((item) {
    //     return Chat.fromJson(item);
    //   }).toList();
    //
    //   return chatList;
    // } else {
    //   throw Exception('Response status: ${response.statusCode}');
    // }

    /// dio 网络库实现网络请求。接口返回的就是 Map数据，数据转换流程是：Map ==> Model
    var rp = await HttpManager.dio.get('http://rap2api.taobao.org/app/mock/291253/api/chat/list');

    if (rp.statusCode == success)  {

      List<Chat> chatList = rp.data['chat_list'].map<Chat>((item) {
        return Chat.fromJson(item);
      }).toList();

      return chatList;

    } else {
      throw Exception('Response status: ${rp.statusCode}');
    }

  }

  // loading...
  Widget _loading() {
    return Center(
      child: Text('加载中...'),
    );
  }

  // 返回cell
  Widget _cellForRow(BuildContext context, int index) {

    // 搜索框
    if (index == 0) {
      return ChatSearchCell(datas: _chatDatas);
    }

    // 用户聊天cell
    Chat model = _chatDatas[index - 1];
    return ListTile(
      title: Text(model.name ?? ''),
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '微信',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: WeChatThemeColor,
        elevation: 0.0, // 没有底部的边栏
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            // 用 Container 包裹 PopupMenuButton，便于调整 PopupMenuButton 的位置
            child: PopupMenuButton(
              color: Color.fromRGBO(1, 1, 1, 0.65),
              offset: Offset(0, 60), // 弹窗距离 child 的偏移量
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  PopupMenuItem(
                    child:
                        _buildPopupMenuItem('images/wc_group_chat.png', '发起群聊'),
                  ),
                  PopupMenuItem(
                    child:
                        _buildPopupMenuItem('images/wc_group_chat.png', '添加朋友'),
                  ),
                  PopupMenuItem(
                    child:
                        _buildPopupMenuItem('images/wc_scan_white.png', '扫一扫'),
                  ),
                  PopupMenuItem(
                    child:
                        _buildPopupMenuItem('images/wc_receiving.png', '收付款'),
                  ),
                ];
              },
              child: Image(
                image: AssetImage('images/wc_circle_add.png'),
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: _chatDatas.length == 0 ? _loading() : ListView.builder(
            itemCount: 1 + _chatDatas.length, // 1是搜索框cell
            itemBuilder: _cellForRow,
        ),
      ),
    );
  }
}
