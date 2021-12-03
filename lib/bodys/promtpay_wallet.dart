import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class PromtpayWallet extends StatefulWidget {
  const PromtpayWallet({Key? key}) : super(key: key);

  @override
  _PromtpayWalletState createState() => _PromtpayWalletState();
}

class _PromtpayWalletState extends State<PromtpayWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTitle(),
          buildSubTitle(),
          buildQRcode(),
          buildDownload()
        ],
      ),
    );
  }

  ElevatedButton buildDownload() => ElevatedButton(
      onPressed: () async {
        String path = '/sdcard/download';
        try {
          await FileUtils.mkdir([path]);

          await Dio()
              .download(Myconstant.urlQRcode, '$path/promptpay.png')
              .then(
                (value) => ShowProgress(),
              );
        } catch (e) {
          print('### error ==> ${e.toString()}');
          MyDialog().normalDialog(context, 'Permission Denied',
              'Please allow perrmission to Storage');
        }
      },
      child: Text('Download QRcode'));

  Container buildQRcode() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: Myconstant.urlQRcode,
        placeholder: (context, url) => ShowProgress(),
      ),
    );
  }

  Widget buildSubTitle() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 30,
      ),
      child: Card(
        color: Colors.indigo.shade100,
        child: ListTile(
          leading: Container(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: showImage(path: Myconstant.promtpayImg),
            ),
          ),
          title: ShowTitle(
            title: '0612019351',
            textStyle: Myconstant().h1BStyle(),
          ),
          subtitle: ShowTitle(title: 'บัญชี Promptpay'),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: '0612019351'),
              );
            },
            icon: Icon(Icons.copy),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ShowTitle(
          title: 'การโอนเงินโดยใช้พร้อมเพย์',
          textStyle: Myconstant().h1Style(),
        ),
      ),
    );
  }
}
