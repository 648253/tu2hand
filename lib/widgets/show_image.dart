import 'package:flutter/material.dart';

// ignore: camel_case_types
class showImage extends StatelessWidget {
  final String path;
  const showImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}
