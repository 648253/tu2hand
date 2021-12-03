import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderBuyer extends StatefulWidget {
  const MyOrderBuyer({Key? key}) : super(key: key);

  @override
  _MyOrderBuyerState createState() => _MyOrderBuyerState();
}

class _MyOrderBuyerState extends State<MyOrderBuyer> {
  String? idBuyer;
  bool statusOrder = true;
  List<OrderModel> orderModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: statusOrder ? showNoOrder() : buildContent(),
    );
  }

  Widget buildContent() => ListView.builder(itemCount: orderModels.length,
        itemBuilder: (context, index) => Column(
          children: [
            Text(orderModels[index].namePd),
          ],
        ),
      );

  Center showNoOrder() {
    return Center(
      child: Container(
        child: Text(
          'Order is Empty!',
          style: Myconstant().h1Style(),
        ),
      ),
    );
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idBuyer = preferences.getString('id')!;
    String apiGetIdBuyer =
        '${Myconstant.domain}/tu2hand/getOrderWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(apiGetIdBuyer).then((value) {
      //print('value from api ==> $value');
      for (var item in json.decode(value.data)) {
        OrderModel orderModel = OrderModel.fromMap(item);
        setState(() {
          statusOrder = false;
          orderModels.add(orderModel);
        });
      }
    });
  }
}
