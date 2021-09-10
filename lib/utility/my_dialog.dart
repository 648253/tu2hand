import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class MyDialog {
  Future<Null> alertLocationService(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: showImage(path: Myconstant.image6),
          title: ShowTitle(
            title: 'Location Service is closed ?',
            textStyle: Myconstant().h2Style(),
          ),
          subtitle: ShowTitle(
              title: 'Please Open Location Sevice',
              textStyle: Myconstant().h3Style()),
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
}
