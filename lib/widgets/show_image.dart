import 'package:flutter/material.dart';

class showImage extends StatelessWidget {
  final String path;
  const showImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}
