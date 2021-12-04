import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
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
  List<OrderModel> orderModels = [];
  List<List<String>> listOrderPd = [];
  List<List<String>> listPrices = [];
  List<List<String>> listAmounts = [];
  List<List<String>> listSums = [];
  List<int> totals = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNreadIdSeller();
  }

  Future<Null> findNreadIdSeller() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idSeller = preferences.getString(Myconstant().keyId);
    //print('### idShop ==> $idSeller');
    String path =
        '${Myconstant.domain}/tu2hand/getOrderWhereIdSeller.php?isAdd=true&idSeller=$idSeller';
    await Dio().get(path).then((value) {
      //print('### value ==> $value');
      for (var map in json.decode(value.data)) {
        OrderModel orderModel = OrderModel.fromMap(map);
        //print('### orderModel ==> ${model}');

        List<String> orderPd = Myconstant().changeToArrays(orderModel.namePd);
        List<String> orderPrice =
            Myconstant().changeToArrays(orderModel.pricePd);
        List<String> orderAmount =
            Myconstant().changeToArrays(orderModel.amountPd);
        List<String> orderSum = Myconstant().changeToArrays(orderModel.sumPd);

        int total = 0;
        for (var string in orderSum) {
          total = total + int.parse(string.trim());
        }

        print('### total ==> $total');

        setState(() {
          orderModels.add(orderModel);
          listOrderPd.add(orderPd);
          listPrices.add(orderPrice);
          listAmounts.add(orderAmount);
          listSums.add(orderSum);
          totals.add(total);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderModels.length == 0
          ? ShowProgress()
          : ListView.builder(
              itemCount: orderModels.length,
              itemBuilder: (context, index) => Card(color: index%2 == 0 ? Colors.teal.shade300 : Colors.teal.shade100,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildEmptyBlock(),
                      buildOrderDetail(index),
                      Myconstant().buildHeadOrder(),
                      buildListViewPd(index),
                      buildTotal(index),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    primary: Colors.red.shade600),
                                onPressed: () {},
                                icon: Icon(Icons.cancel_sharp),
                                label: Text('Cancel')),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    primary: Colors.green.shade600),
                                onPressed: () {},
                                icon: Icon(Icons.cancel_sharp),
                                label: Text('Confirm')),
                          ],
                        ),
                      ),
                      buildEmptyBlock(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  ListView buildListViewPd(int index) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: listOrderPd[index].length,
        itemBuilder: (context, index2) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(listOrderPd[index][index2]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(listPrices[index][index2]),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(listAmounts[index][index2]),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(listSums[index][index2]),
              ),
            ],
          ),
        ),
      );

  Widget buildTotal(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShowTitle(title: 'Total : '),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                ShowTitle(
                  title: ' ${totals[index].toString()} THB',
                  textStyle: Myconstant().h3WStyle(),
                )
              ],
            ),
          ),
        ],
      );

  Padding buildOrderDetail(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowTitle(
            title: 'ชื่อผู้สั่ง : ${orderModels[index].nameBuyer}',
            textStyle: Myconstant().h2Style(),
          ),
          ShowTitle(
            title: 'เวลาออเดอร์ : ${orderModels[index].dateTime}',
          ),
          ShowTitle(
            title: 'ที่อยู่ : ${orderModels[index].addressBuyer}',
          ),
          ShowTitle(
            title: 'มือถือ : ${orderModels[index].phoneBuyer}',
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
