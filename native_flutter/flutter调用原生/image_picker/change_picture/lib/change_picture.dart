
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChangePictureDemo extends StatefulWidget {
  const ChangePictureDemo({Key? key}) : super(key: key);

  @override
  _ChangePictureDemoState createState() => _ChangePictureDemoState();
}

class _ChangePictureDemoState extends State<ChangePictureDemo> {

  // 头像
  File? _avatarFile;

  ImageProvider _avatarImage() {
    if (_avatarFile == null) {
      return AssetImage('images/wc_avatar.png');
    } else {
      return FileImage(_avatarFile!);
    }
  }

  // 初始化方法
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: GestureDetector(
        onTap: () {
          ImagePicker().getImage(source: ImageSource.gallery).then((value) {
            setState(() {
              _avatarFile = File(value.path);
            });
          });
        },
        child: Row(
          children: [
            Text(
              '点击黑色icon',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Image(
              image: _avatarImage(),
            ),
          ],
        ),
      ),
    );
  }
}


