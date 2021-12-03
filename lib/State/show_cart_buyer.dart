import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/sqlite_helper.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCartBuyer extends StatefulWidget {
  const ShowCartBuyer({Key? key}) : super(key: key);

  @override
  _ShowCartBuyerState createState() => _ShowCartBuyerState();
}

class _ShowCartBuyerState extends State<ShowCartBuyer> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  UserModel? userModel;
  int? total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readSQLite().then((value) {
      //print('### valueOnProcessReadSQLite ==> $value');
      setState(() {
        load = false;
        sqliteModels = value;
        findDetailSeller();
        calTotal();
      });
    });
  }

  void calTotal() async {
    total = 0;
    for (var item in sqliteModels) {
      int sumInt = int.parse(item.sum.trim());
      setState(() {
        total = total! + sumInt;
      });
    }
  }

  Future<Null> findDetailSeller() async {
    if (sqliteModels.isNotEmpty) {
      String idSeller = sqliteModels[0].idSeller;

      //print('### idSeller ==> $idSeller');
      String apiGetUserWhereId =
          '${Myconstant.domain}/tu2hand/getUserWhereId.php?isAdd=true&id=$idSeller';
      await Dio().get(apiGetUserWhereId).then((value) {
        for (var item in json.decode(value.data)) {
          setState(() {
            userModel = UserModel.fromMap(item);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
      body: load
          ? ShowProgress()
          : sqliteModels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: 200,
                        child: showImage(path: Myconstant.image6),
                      ),
                      ShowTitle(
                          title: 'Empty!', textStyle: Myconstant().h1Style()),
                    ],
                  ),
                )
              : buildContent(),
    );
  }

  Column buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showSellerCart(),
        builldHead(),
        listProduct(),
        buildDivider(),
        buildTotal(),
        buildDivider(),
        buttonController(),
      ],
    );
  }

  Future<Null> confirmEmptyCart() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: showImage(path: Myconstant.image6),
          title: ShowTitle(
            title: 'ลบข้อมูลสินค้าทั้งหมด ?',
            textStyle: Myconstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: 'ข้อมูลสินค้าในตะกร้าของคุณจะหายไปทั้งหมด ยืนยัน?',
            textStyle: Myconstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SQLiteHelper().clearSQLite().then((value) {
                Navigator.pop(context);
                processReadSQLite();
              });
            },
            child: Text('Confirm'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Row buttonController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Myconstant.routeAddWallet);
          },
          child: Text('Order'),
        ),
        Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: ElevatedButton(
              onPressed: () => confirmEmptyCart(),
              child: Text('Clear'),
            )),
      ],
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Total :',
                textStyle: Myconstant().h2Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: total == null ? '' : total.toString(),
                textStyle: Myconstant().h1Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Myconstant.dark,
      thickness: 1,
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ShowTitle(
                title: sqliteModels[index].name,
                textStyle: Myconstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: sqliteModels[index].price,
                textStyle: Myconstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShowTitle(
                  title: sqliteModels[index].amount,
                  textStyle: Myconstant().h3Style(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: sqliteModels[index].sum,
                textStyle: Myconstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {
                  int idSQLite = sqliteModels[index].id!;
                  print('### Delete idSQLite ===> $idSQLite');
                  SQLiteHelper()
                      .deleteSQLiteWhereId(idSQLite)
                      .then((value) => processReadSQLite());
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container builldHead() {
    return Container(
      decoration: BoxDecoration(color: Myconstant.light),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ShowTitle(
                  title: 'Product',
                  textStyle: Myconstant().h2Style(),
                ),
              ),
              Expanded(
                flex: 1,
                child: ShowTitle(
                  title: 'Price',
                  textStyle: Myconstant().h2Style(),
                ),
              ),
              Expanded(
                flex: 1,
                child: ShowTitle(
                  title: 'Vol.',
                  textStyle: Myconstant().h2Style(),
                ),
              ),
              Expanded(
                flex: 1,
                child: ShowTitle(
                  title: 'Sum',
                  textStyle: Myconstant().h2Style(),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding showSellerCart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: userModel == null ? '' : cutWord(userModel!.name),
        textStyle: Myconstant().h1Style(),
      ),
    );
  }

  String cutWord(String string) {
    String result = string;
    if (result.length >= 30) {
      result = result.substring(0, 30);
      result = '$result ...';
    }
    return result;
  }
}
