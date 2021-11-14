import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class MyDialog {
  Future<Null> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
          child: Center(child: CircularProgressIndicator(color: Myconstant.dark,)),
          onWillPop: () async {
            return false;
          }),
    );
  }

  Future<Null> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: showImage(path: Myconstant.image6),
          title: ShowTitle(
            title: title,
            textStyle: Myconstant().h2Style(),
          ),
          subtitle:
              ShowTitle(title: message, textStyle: Myconstant().h3Style()),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                exit(0);
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: showImage(path: Myconstant.image6),
          title: ShowTitle(title: title, textStyle: Myconstant().h3Style()),
          subtitle:
              ShowTitle(title: message, textStyle: Myconstant().h3Style()),
        ),
        children: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }
}
