import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class ShowMangeSeller extends StatefulWidget {
  final UserModel userModel;
  const ShowMangeSeller({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowMangeSellerState createState() => _ShowMangeSellerState();
}

class _ShowMangeSellerState extends State<ShowMangeSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  Future<Null> refreshUserModel() async {
    print('### refreshUserModelWork');
    String apiGetUserWhereId =
        '${Myconstant.domain}/tu2hand/getUserWhereId.php?isAdd=true&id=${userModel!.id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  String cutWord(String detailPd) {
    String result = detailPd;
    if (result.length >= 25) {
      result = result.substring(0, 25);
      result = '$result...';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Myconstant.primary,
          child: Icon(Icons.edit,color: Colors.white,),
          onPressed: () =>
              Navigator.pushNamed(context, Myconstant.routeSellerEditProfile)
                  .then((value) => refreshUserModel()),
        ),
        body: buildContent());
  }

  LayoutBuilder buildContent() {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShowTitle(
                    title: 'แก้ไขโปรไฟล์ ',
                    textStyle: Myconstant().h1BStyle(),
                  ),
                  Icon(Icons.mode_edit_outline_outlined),
                ],
              ),
              Card(
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    Myconstant().buildEmptyBlock(),
                    Myconstant().buildEmptyBlock(),
                    Myconstant().buildEmptyBlock(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  '${Myconstant.domain}${userModel!.img}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Myconstant().buildEmptyBlock(),
                    Myconstant().buildEmptyBlock(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShowTitle(
                          title: 'รูปโปรไฟล์ ',
                          textStyle: Myconstant().h2Style(),
                        ),
                        Icon(Icons.portrait_rounded),
                      ],
                    ),
                    Myconstant().buildEmptyBlock(),
                  ],
                ),
              ),
              Myconstant().buildEmptyBlock(),
              Row(
                children: [
                  ShowTitle(
                    title: 'ชื่อร้าน  ',
                    textStyle: Myconstant().h1BStyle(),
                  ),
                  Icon(Icons.store_mall_directory_outlined),
                ],
              ),
              Myconstant().buildEmptyBlock(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShowTitle(
                      title: cutWord(userModel!.name),
                      textStyle: Myconstant().h2Style()),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade400,
              ),
              Myconstant().buildEmptyBlock(),
              Myconstant().buildEmptyBlock(),
              Row(
                children: [
                  ShowTitle(
                    title: 'ที่อยู่  ',
                    textStyle: Myconstant().h1BStyle(),
                  ),
                  Icon(Icons.mail_outline),
                ],
              ),
              Myconstant().buildEmptyBlock(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.6,
                    child: ShowTitle(
                      title: userModel!.address,
                      textStyle: Myconstant().h2Style(),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade400,
              ),
              Myconstant().buildEmptyBlock(),
              Myconstant().buildEmptyBlock(),
              Row(
                children: [
                  ShowTitle(
                    title: 'เบอร์โทร  ',
                    textStyle: Myconstant().h1BStyle(),
                  ),
                  Icon(Icons.phone_android_outlined),
                ],
              ),
              Myconstant().buildEmptyBlock(),
              ShowTitle(
                title: '${userModel!.phone}',
                textStyle: Myconstant().h2Style(),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade400,
              ),
              Myconstant().buildEmptyBlock(),
              Myconstant().buildEmptyBlock(),
              Row(
                children: [
                  ShowTitle(
                    title: 'ตำแหน่ง  ',
                    textStyle: Myconstant().h1BStyle(),
                  ),
                  Icon(Icons.pin_drop_outlined),
                ],
              ),
              Myconstant().buildEmptyBlock(),
              Card(
                color: Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      height: constraints.maxWidth * 0.6,
                      color: Colors.grey,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(userModel!.lat),
                            double.parse(userModel!.long),
                          ),
                          zoom: 16,
                        ),
                        markers: <Marker>[
                          Marker(
                            markerId: MarkerId('id'),
                            position: LatLng(
                              double.parse(userModel!.lat),
                              double.parse(userModel!.long),
                            ),
                            infoWindow: InfoWindow(
                                title: 'คุณอยู่นี่ ',
                                snippet:
                                    'lat = ${userModel!.lat} , lng = ${userModel!.long}'),
                          ),
                        ].toSet(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
