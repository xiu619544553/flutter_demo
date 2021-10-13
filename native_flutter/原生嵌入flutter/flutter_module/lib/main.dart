import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_module/demo1.dart';
import 'package:flutter_module/demo2.dart';
import 'package:flutter_module/message_channel.dart';

// demo1
// void main() => runApp(
//     FirstDemo(
//       pageIndex: window.defaultRouteName,
//     )
// );

// demo2
// void main() => runApp(
//     SecondDemo()
// );

// BasicMessageChannel 案例
void main() => runApp(
    MessageChannelDemo()
);