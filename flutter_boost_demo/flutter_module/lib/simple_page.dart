
import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {

  final String? data;

  const SimplePage({
    @required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data ?? '',
        style: TextStyle(
          fontSize: 25,
          color: Colors.red,
        ),
      ),
    );
  }
}
