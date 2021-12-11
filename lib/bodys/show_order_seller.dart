import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowOrderSeller extends StatefulWidget {
  const ShowOrderSeller({Key? key}) : super(key: key);

  @override
  _ShowOrderSellerState createState() => _ShowOrderSellerState();
}

class _ShowOrderSellerState extends State<ShowOrderSeller> {
  String? idSeller;
  bool statusOrder = true;
  bool load = true;
  List<OrderModel> orderModels = [];
  List<String> listOrderNameSellers = [];
  List<String> listOrderNames = [];
  List<String> listOrderPrices = [];
  List<String> listOrderAmounts = [];
  List<String> listOrderIdBuyer = [];
  List<String> listOrderNameBuyer = [];
  List<String> listOrderAddress = [];
  List<String> listOrderPhone = [];
  List<String> listOrderSums = [];
  List<String> listOrderImgs = [];
  List<int> setStatusInts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNreadIdSeller();
  }

  Future<Null> findNreadIdSeller() async {
    if (orderModels.isNotEmpty) {
      orderModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idSeller = preferences.getString('id')!;
    String apiGetIdBuyer =
        '${Myconstant.domain}/tu2hand/getOrderWhereIdSeller.php?isAdd=true&idSeller=$idSeller';
    await Dio().get(apiGetIdBuyer).then((value) {
      //print('value from api ==> $value');
      for (var map in json.decode(value.data)) {
        OrderModel orderModel = OrderModel.fromMap(map);
        setState(() {
          load = false;
          orderModels.add(orderModel);
          listOrderNameSellers.add(orderModel.nameShop);
          listOrderNames.add(orderModel.namePd);
          listOrderPrices.add(orderModel.pricePd);
          listOrderAmounts.add(orderModel.amountPd);
          listOrderIdBuyer.add(orderModel.idBuyer);
          listOrderNameBuyer.add(orderModel.nameBuyer);
          listOrderAddress.add(orderModel.addressBuyer);
          listOrderPhone.add(orderModel.phoneBuyer);
          listOrderSums.add(orderModel.sumPd);
          listOrderImgs.add(orderModel.imgPd);
        });
      }
    });
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

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: orderModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,left: 8),
                  child: ShowTitle(
                      title: 'ชื่อผู้สั่ง :  ${orderModels[index].nameBuyer}'),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,left: 8),
                  child: ShowTitle(
                      title: 'ที่อยู่ :  ${orderModels[index].addressBuyer}'),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,left: 8),
                  child: ShowTitle(
                      title: 'เบอร์โทร :  ${orderModels[index].phoneBuyer}'),
                ),
              ],
            ),
            Myconstant().buildEmptyBlock(),
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
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ShowTitle(
                                        textStyle: Myconstant().h2BlStyle(),
                                        title: 'สถานะ : '),
                                  ),
                                  changeColorsStatus(orderModels[index].status),
                                  changeIconStatus(orderModels[index].status),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buttonStatus(index),
            Divider(
              thickness: 1,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Padding changeColorsStatus(String status) {
    if (status == 'ยกเลิก') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5),
        child: ShowTitle(textStyle: Myconstant().h2Style(), title: '$status'),
      );
    } else if (status == 'เตรียมสินค้า') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5),
        child:
            ShowTitle(textStyle: Myconstant().h2BlaStyle(), title: '$status'),
      );
    } else if (status == 'แพ็คสินค้า') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5),
        child: ShowTitle(textStyle: Myconstant().h2BStyle(), title: '$status'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5),
        child: ShowTitle(textStyle: Myconstant().h2BStyle(), title: '$status'),
      );
    }
  }

  Padding changeIconStatus(String status) {
    if (status == 'ยกเลิก') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10),
        child: Icon(Icons.cancel_outlined),
      );
    } else if (status == 'เตรียมสินค้า') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10),
        child: Icon(Icons.watch_later_outlined),
      );
    } else if (status == 'แพ็คสินค้า') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10),
        child: Icon(Icons.archive_outlined),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10),
        child: Icon(Icons.airport_shuttle_outlined),
      );
    }
  }

  Padding buttonStatus(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.green.shade600),
              onPressed: () {
                String status = 'แพ็คสินค้า';
                updateStatus(
                    orderModels[index].idBuyer, orderModels[index].id, status);
              },
              icon: Icon(Icons.check),
              label: Text('Confirm')),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.red.shade600),
              onPressed: () {
                String status = 'ยกเลิก';
                updateStatus(
                    orderModels[index].idBuyer, orderModels[index].id, status);
              },
              icon: Icon(Icons.cancel_sharp),
              label: Text('Cancel')),
        ],
      ),
    );
  }

  Future<Null> updateStatus(String idBuyer, String id, String status) async {
    String path =
        '${Myconstant.domain}/tu2hand/editStatusOrderWhereId.php?isAdd=true&idBuyer=$idBuyer&id=$id&status=$status';
    Dio().get(path).then((value) => findNreadIdSeller());
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

  SizedBox buildEmptyBlock() {
    return SizedBox(
      width: 12,
      height: 10,
    );
  }
}
