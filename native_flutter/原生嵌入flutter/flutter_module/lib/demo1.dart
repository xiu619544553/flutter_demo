
import 'package:flutter/material.dart';


class FirstDemo extends StatelessWidget {
  final String? pageIndex;

  const FirstDemo({Key? key, this.pageIndex}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _rootPage(pageIndex ?? ''),
    );
  }

  Widget? _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageIndex,
            ),
          ),
          body: Center(
            child: Text(
              pageIndex,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        );

      case 'two':
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageIndex,
            ),
          ),
          body: Center(
            child: Text(
              pageIndex,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        );

      default:
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '默认页面',
            ),
          ),
          body: Center(
            child: Text(
              pageIndex,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        );
    }
  }
}
