import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
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
  List<OrderModel> orderModels = [];
  List<List<String>> listOrderPd = [];
  List<List<String>> listPrices = [];
  List<List<String>> listAmounts = [];
  List<List<String>> listSums = [];
  List<int> totals = [];
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
      body: orderModels == null ? showNoOrder() : buildContent(),
    );
  }

  Widget buildContent() => ListView.builder(
        itemCount: orderModels.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildEmptyBlock(),
              buildNameShop(index),
              buildDateTimeOrder(index),
              Myconstant().buildHeadOrder(),
              buildListViewPd(index),
              buildTotal(index),
              buildEmptyBlock(),
              buildStepIndicator(setStatusInts[index]),
              buildEmptyBlock(),
            ],
          ),
        ),
      );

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
                Text('Canceled'),
                Text('Preparing'),
                Text('Packaged'),
                Text('Delivered'),
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
                  textStyle: Myconstant().h3BStyle(),
                )
              ],
            ),
          ),
        ],
      );

  ListView buildListViewPd(int index) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: listOrderPd[index].length,
        itemBuilder: (context, index2) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
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



  Container buildDateTimeOrder(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ShowTitle(
            title: 'Order Time : ${orderModels[index].dateTime}',
            textStyle: Myconstant().h2BlStyle(),
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
    ShowProgress();
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
      for (var map in json.decode(value.data)) {
        OrderModel orderModel = OrderModel.fromMap(map);
        List<String> orderPd = Myconstant().changeToArrays(orderModel.namePd);
        List<String> orderPrice = Myconstant().changeToArrays(orderModel.pricePd);
        List<String> orderAmount = Myconstant().changeToArrays(orderModel.amountPd);
        List<String> orderSum = Myconstant().changeToArrays(orderModel.sumPd);
        int status = updateStatus(orderModel);

        int total = 0;
        for (var string in orderSum) {
          total = total + int.parse(string.trim());
        }

        //print('### total ==> $total');

        print('my string/// ==> $orderPd');
        setState(() {
          statusOrder = false;
          orderModels.add(orderModel);
          listOrderPd.add(orderPd);
          listPrices.add(orderPrice);
          listAmounts.add(orderAmount);
          listSums.add(orderSum);
          totals.add(total);
          setStatusInts.add(status);
        });
      }
    });
  }

  int updateStatus(OrderModel orderModel) {
    int status = 0;
    switch (orderModel.status) {
      case 'cancel':
        status = 0;
        break;
      case 'preparing':
        status = 1;
        break;
      case 'packaged':
        status = 2;
        break;
      case 'delivered':
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
