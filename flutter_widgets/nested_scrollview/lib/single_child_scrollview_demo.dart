

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatelessWidget {

  // SingleChildScrollView 不支持 Sliver的按需加载模型

  @override
  Widget build(BuildContext context) {

    String str = "SingleChildScrollView 不支持 Sliver的按需加载模型";

    return Scrollbar(child: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: str.split("").map((e) {
            return Text(
              e,
              textScaleFactor: 2.0,
            );
          }).toList(),
        ),
      ),
    ));
  }
}
