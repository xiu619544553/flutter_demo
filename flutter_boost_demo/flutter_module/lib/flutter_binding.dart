
import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_flutter_binding.dart';

//这里要特别注意，如果你的工程里已经有一个继承自WidgetsFlutterBinding的自定义Binding，则只需要将其with上BoostFlutterBinding
//如果你的工程没有自定义的Binding，则可以参考这个CustomFlutterBinding的做法
//BoostFlutterBinding用于接管Flutter App的生命周期，必须得接入的
class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {

}
