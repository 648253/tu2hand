import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/bodys/my_order.dart';
import 'package:myfirstpro/bodys/my_money.dart';
import 'package:myfirstpro/bodys/show_all_shop_buyer.dart';
import 'package:myfirstpro/models/cart_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_signout.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
    findDetailSeller();
  }

  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  List<CartModel> cartModels = [];
  int indexWidgets = 0;
  String? idBuyer;
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Badge(
              position: BadgePosition.topEnd(),
              badgeColor: Colors.green,
              badgeContent: Text('${cartModels.length}',
                  style: TextStyle(color: Colors.white)),
              animationDuration: Duration(milliseconds: 300),
              child: IconButton(
                onPressed: () {
                  findDetailSeller();
                  Navigator.pushNamed(context, Myconstant.routeBuyerShowCart);
                },
                icon: Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
        title: Text('Buyer'),
      ),
      drawer: widgets.length == 0
          ? SizedBox()
          : Drawer(
              child: Stack(
                children: [
                  Column(
                    children: [
                      buildHeader(),
                      menuShowAllShop(),
                      menuMyMoney(),
                      menuMyOrder(),
                    ],
                  ),
                  ShowSignOut(),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidgets],
    );
  }

  Future<Null> findDetailSeller() async {
    if (cartModels.isNotEmpty) {
      cartModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idBuyer = preferences.getString(Myconstant().keyId);
    String path =
        '${Myconstant.domain}/tu2hand/getCartWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(path).then((value) {
      String s = value.data.toString();
      //print('${s == 'null'}');
      if (s == 'null') {
      } else {
        for (var map in json.decode(value.data)) {
          CartModel cartModel = CartModel.fromMap(map);
          //print(cartModel);
          //  List<String> cartNamePd = cartModel.namePd;
          setState(() {
            cartModels.add(cartModel);
          });
        }
      }
    });
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.storefront,
        size: 36,
        color: Myconstant.dark,
      ),
      title:
          ShowTitle(title: 'Show All Shop', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงร้านค้าทั้งหมด', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.account_balance_wallet_outlined,
        size: 36,
        color: Myconstant.dark,
      ),
      title: ShowTitle(title: 'MyMoney', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงจำนวนเงินทั้งหมด', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag_outlined,
        size: 36,
        color: Myconstant.dark,
      ),
      title: ShowTitle(title: 'MyOrder', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงรายการสั่งซ์้อ', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 2;
          Navigator.pop(context);
        });
      },
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
              NetworkImage('${Myconstant.domain}${userModel?.img}'),
        ),
        accountName: Text(userModel == null ? 'Name ?' : userModel!.name),
        accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type));
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = '3';
    print('## id login ==> $id');
    String apiGetUserWhereId =
        '${Myconstant.domain}/tu2hand/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      print('## value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          print('${userModel!.img}');
          widgets.add(ShowAllShopBuyer());
          widgets.add(MyMoneyBuyer());
          widgets.add(MyOrderBuyer());
        });
      }
    });
  }
}
