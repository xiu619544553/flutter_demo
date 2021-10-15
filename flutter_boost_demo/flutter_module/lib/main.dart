import 'package:flutter/material.dart';
import 'flutter_binding.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'lifestyle_binding.dart';
import 'main_page.dart';
import 'simple_page.dart';

void main() {
  ///添加全局生命周期监听类
  PageVisibilityBinding.instance.addGlobalObserver(AppLifecycleObserver());

  ///这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
  CustomFlutterBinding();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory);
  }

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    print("settings.name ======= ${settings.name}");

    FlutterBoostRouteFactory? func = routerMap[settings.name];

    if (func == null) {
      return null;
    }

    return func(settings, uniqueId);
  }

  /// 注册的路由表
  /// 路由和页面的映射
  static Map<String, FlutterBoostRouteFactory> routerMap = {
    '/mainPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) {

          // =============arguments类型：_InternalLinkedHashMap<String, dynamic>
          print("=============arguments类型：${settings.arguments.runtimeType}");
          print("=============argument：${settings.arguments}");
          // Map<String, dynamic>.from(settings.arguments);

          Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
          var data = map['data'] as String;
          print("=========data：${data}");

          return MainPage(
            data: data,
          );
        },
      );
    },
    '/simplePage': (settings, uniqueId) {

      return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) {
          return SimplePage(data: "加单页面");
        },
      );
    }
  };
}
