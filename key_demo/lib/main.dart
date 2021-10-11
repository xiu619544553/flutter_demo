import 'package:flutter/material.dart';
import 'package:key_demo/key_demo.dart';


/// 关于构造函数的 key
/// const StfItem({Key? key}) : super(key: key);
/*

Key本身是一个抽象类它有2大类：

1、LocalKey，用作diff算法的核心所在。用作Element和Widget进行比较。它的3个子类如下
  * ValueKey，以一个任意类型的数据作为key。如：数字、字符
  * ObjectKey，以Object对象作为key
  * UniqueKey，可以保证key的唯一性！（一旦使用唯一，那么就不存在Element复用了）

2、GlobalKey
  *

 */

abstract class Key {
  /// Construct a [ValueKey<String>] with the given [String].
  ///
  /// This is the simplest way to create keys.
  const factory Key(String value) = ValueKey<String>;

  /// Default constructor, used by subclasses.
  ///
  /// Useful so that subclasses can call us, because the [new Key] factory
  /// constructor shadows the implicit constructor.
  @protected
  const Key.empty();
}
*/


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      home: KeyDemoPage(),
    );
  }
}


