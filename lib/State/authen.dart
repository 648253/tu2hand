import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child:
              Container(width: size*0.6, 
              child: showImage(path: Myconstant.image1))),
    );
  }
}
