import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfirstpro/bodys/show_manage_seller.dart';
import 'package:myfirstpro/bodys/show_order_seller.dart';
import 'package:myfirstpro/bodys/show_product_seller.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_signout.dart';
import 'package:myfirstpro/widgets/show_title.dart';


class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('## id login ==> $id');
    String apiGetUserWhereId =
        '${Myconstant.domain}/tu2hand/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      print('## value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          widgets.add(ShowOrderSeller());
          widgets.add(ShowMangeSeller(userModel: userModel!));
          widgets.add(ShowProductSeller());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.dark,
        title: userModel == null ? ShowProgress() : Text('${userModel!.name}'),
      ),
      drawer: widgets.length == 0
          ? SizedBox()
          : Drawer(
              child: Stack(
                children: [
                  ShowSignOut(),
                  Column(
                    children: [
                      buildHeader(),
                      menuShowOrder(),
                      menuShopManage(),
                      menuShowProduct(),
                    ],
                  ),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidget],
    );
  }

  UserAccountsDrawerHeader buildHeader() {
    return UserAccountsDrawerHeader(
        otherAccountsPictures: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.portrait),
            iconSize: 36,
            color: Myconstant.light,
            tooltip: 'Edit Profile',
          ),
        ],
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Myconstant.light, Myconstant.dark],
            center: Alignment(-0.7, -0.2),
            radius: 1,
          ),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage:
              NetworkImage('${Myconstant.domain}${userModel!.img}'),
        ),
        accountName: Text(userModel == null ? 'Name ?' : userModel!.name),
        accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type));
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งซื้อลูกค้า',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }

  ListTile menuShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'Show Manage',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดหน้าร้าน',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดสินค้า',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }
}
