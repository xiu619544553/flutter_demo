import 'package:flutter/material.dart';

import 'change_picture.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '更换图片',
          ),
        ),
        body: Center(
          child: ChangePictureDemo(),
        ),
      ),
    );
  }
}
