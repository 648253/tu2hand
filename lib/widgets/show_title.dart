import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;

  const ShowTitle({
    Key? key,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle == null ? Myconstant().h3Style() : textStyle,
    );
  }
}
