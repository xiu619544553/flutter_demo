import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ListView 原理
/// ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：

/// 1、ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
/// 2、一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
/// 3、ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent ，则会使用 SliverFixedExtentList；如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。

/// Demo
class ListViewDemo extends StatelessWidget {
  final int? style;

  const ListViewDemo({this.style});

  Widget _buildTitle(int? style) {
    if (style == 1) {
      return Text("ListView 默认构造函数，适合少量子组件");
    } else if (style == 2) {
      return Text("ListView.builder 按需动态构建列表项");
    } else if (style == 3) {
      return Text("ListView.separated 支持分割组件");
    } else if (style == 4) {
      return Text("ListView 设置固定高度");
    } else if (style == 5) {
      return Text("ListView 无限加载列表");
    } else if (style == 6) {
      return Text("ListView 添加固定列表头");
    }

    return Text("ListView");
  }

  Widget _buildSubWidget(int? style) {

    print("style = $style");

    if (style == 1) {
      return ListViewDemo1();
    } else if (style == 2) {
      return ListViewDemo2();
    } else if (style == 3) {
      return ListViewDemo3();
    } else if (style == 4) {
      return FixedExtentList();
    } else if (style == 5) {
      return InfiniteListView();
    } else if (style == 6) {
      return GoodsListDemo();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(style),
      ),
      body: _buildSubWidget(style),
    );
  }
}


/// 1、ListView 默认构造函数
/// 默认构造函数有一个children参数，它接受一个Widget列表（List<Widget>）。这种方式适合只有少量的子组件数量已知且比较少的情况
class ListViewDemo1 extends StatelessWidget {
  const ListViewDemo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        const Text('第一行'),
        const Text('第二行'),
        const Text('第三行'),
        const Text('第四行'),
      ],
    );
  }
}


/// 2、ListView.builder 按需动态构建列表项
class ListViewDemo2 extends StatelessWidget {
  const ListViewDemo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        });
  }
}


/// 3、ListView.separated
/// ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。
class ListViewDemo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(
      color: Colors.black,
      height: 2,
    );
    Widget divider2 = Divider(
      color: Colors.red,
      height: 2,
    );
    return ListView.separated(
      itemCount: 100,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    );
  }
}


/// 4、固定高度列表
class FixedExtentList extends StatelessWidget {
  const FixedExtentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // 指定子组件的固定高度，能够提高列表的性能
      itemExtent: 56,
      itemBuilder: (context, index) {
        //LayoutLogPrint是一个自定义组件，在布局时可以打印当前上下文中父组件给子组件的约束信息
        return ListTile(title: Text("$index"));
      },
    );
  }
}


/// 5、无限加载列表
class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Widget _buildItem(BuildContext context, int index) {
    //  如果到了表尾
    if (_words[index] == loadingTag) {
      // 不足100条继续获取数据，
      if (_words.length - 1 < 100) {
        // 获取数据
        _retrieveData();
        // 加载时显示loading
        return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      } else {
        // 已经加载了100条数据，不再获取数据。
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16.0),
          child: Text(
            "没有更多了",
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }

    // 显示单词列表项
    return ListTile(title: Text(_words[index]));
  }

  // 生成列表数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 1)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: _buildItem,
      separatorBuilder: (context, index) => Divider(height: .0),
    );
  }
}


/// 6、添加固定列表头
class GoodsListDemo extends StatelessWidget {
  const GoodsListDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 50,
        color: Colors.orange,
        child: Center(
          child: Text("商品列表", style: TextStyle(fontSize: 25),),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          },
          itemCount: 100,
        ),
      ),
    ]);
  }
}
