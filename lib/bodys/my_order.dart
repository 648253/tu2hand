import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

class MyOrderBuyer extends StatefulWidget {
  const MyOrderBuyer({Key? key}) : super(key: key);

  @override
  _MyOrderBuyerState createState() => _MyOrderBuyerState();
}

class _MyOrderBuyerState extends State<MyOrderBuyer> {
  String? idBuyer;
  bool statusOrder = true;
  bool load = true;
  List<OrderModel> orderModels = [];
  List<String> listOrderNameSellers = [];
  List<String> listOrderNames = [];
  List<String> listOrderPrices = [];
  List<String> listOrderAmounts = [];
  List<String> listOrderSums = [];
  List<String> listOrderImgs = [];
  List<int> setStatusInts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : orderModels.isEmpty
              ? showNoOrder()
              : SingleChildScrollView(child: buildContent()),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Myconstant().buildEmptyBlock(),
          Myconstant().buildHeadOrder(),
          Myconstant().buildEmptyBlock(),
          listProduct(),
          Myconstant().buildEmptyBlock(),
          Myconstant().buildEmptyBlock(),
          Myconstant().buildEmptyBlock(),
        ],
      ),
    );
  }

  Widget buildStepIndicator(int step) => Column(
        children: [
          StepsIndicator(
            selectedStepSize: 15,
            unselectedStepColorIn: Colors.white,
            selectedStepColorIn: Colors.red,
            selectedStepColorOut: Colors.blue,
            lineLength: 87,
            selectedStep: step,
            nbSteps: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ยกเลิก'),
                Text('เตรียมสินค้า'),
                Text('แพ็คสินค้า'),
                Text('ดำเนินการส่ง'),
              ],
            ),
          )
        ],
      );

  SizedBox buildEmptyBlock() {
    return SizedBox(
      width: 12,
      height: 10,
    );
  }
  

  Container buildDateTimeOrder(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ShowTitle(
            title: 'เวลาการสั่งซื้อ : ${orderModels[index].dateTime}',
          ),
        ],
      ),
    );
  }

  Row buildNameShop(int index) {
    return Row(
      children: [
        ShowTitle(
          title: 'ร้าน: ${cutWord(orderModels[index].nameShop)}',
          textStyle: Myconstant().h2Style(),
        ),
      ],
    );
  }

  Center showNoOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            width: 200,
            child: showImage(path: Myconstant.image6),
          ),
          ShowTitle(title: 'ว่างเปล่า!', textStyle: Myconstant().h1Style()),
        ],
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
      for (var map in json.decode(value.data)) {
        OrderModel orderModel = OrderModel.fromMap(map);
        int status = updateStatus(orderModel);
        setState(() {
          load = false;
          orderModels.add(orderModel);
          listOrderNameSellers.add(orderModel.nameShop);
          listOrderNames.add(orderModel.namePd);
          listOrderPrices.add(orderModel.pricePd);
          listOrderAmounts.add(orderModel.amountPd);
          listOrderSums.add(orderModel.sumPd);
          listOrderImgs.add(orderModel.imgPd);
          setStatusInts.add(status);
        });
      }
    });
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: orderModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 80,
                          height: 80,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                '${Myconstant.domain}${orderModels[index].imgPd}',
                            placeholder: (context, url) => ShowProgress(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'ร้าน :  ${orderModels[index].nameShop}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'สินค้า : ${orderModels[index].namePd}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    textStyle: Myconstant().h2BlStyle(),
                                    title:
                                        '฿${Myconstant().moneyFormat(orderModels[index].pricePd)}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'จำนวน : x${orderModels[index].amountPd}'),
                              ),
                              buildDateTimeOrder(index),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildStepIndicator(setStatusInts[index]),
          ],
        ),
      ),
    );
  }

  int updateStatus(OrderModel orderModel) {
    int status = 0;
    switch (orderModel.status) {
      case 'ยกเลิก':
        status = 0;
        break;
      case 'เตรียมสินค้า':
        status = 1;
        break;
      case 'แพ็คสินค้า':
        status = 2;
        break;
      case 'ดำเนินการส่ง':
        status = 3;
        break;
      default:
    }
    return status;
  }

  cutWord(String detailPd) {
    String result = detailPd;
    if (result.length >= 20) {
      result = result.substring(0, 20);
      result = '$result...';
    }
    return result;
  }
}
