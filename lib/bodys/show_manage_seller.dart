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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Myconstant.primary,
          child: Icon(Icons.edit),
          onPressed: () =>
              Navigator.pushNamed(context, Myconstant.routeSellerEditProfile)
                  .then((value) => refreshUserModel()),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                      title: 'Name Shop : ', textStyle: Myconstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShowTitle(
                            title: userModel!.name,
                            textStyle: Myconstant().h1Style()),
                      ),
                    ],
                  ),
                  ShowTitle(
                      title: 'Address : ', textStyle: Myconstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowTitle(
                            title: userModel!.address,
                            textStyle: Myconstant().h2Style(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ShowTitle(
                      title: 'Phone : ${userModel!.phone}',
                      textStyle: Myconstant().h2Style()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ShowTitle(
                        title: 'Pic : ', textStyle: Myconstant().h2Style()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: constraints.maxWidth * 0.6,
                        child: CachedNetworkImage(
                          imageUrl: '${Myconstant.domain}${userModel!.img}',
                          placeholder: (context, url) => ShowProgress(),
                        ),
                      ),
                    ],
                  ),
                  ShowTitle(
                      title: 'Location : ', textStyle: Myconstant().h2Style()),
                  Row(
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
                                  title: 'You here ',
                                  snippet:
                                      'lat = ${userModel!.lat} , lng = ${userModel!.long}'),
                            ),
                          ].toSet(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
