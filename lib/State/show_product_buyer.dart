import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myfirstpro/models/product_model.dart';
import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/utility/sqlite_helper.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class ShowProductBuyer extends StatefulWidget {
  final UserModel userModel;
  const ShowProductBuyer({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowProductBuyerState createState() => _ShowProductBuyerState();
}

class _ShowProductBuyerState extends State<ShowProductBuyer> {
  UserModel? userModel;
  bool load = true;
  bool? havePd;
  List<ProductModel> productModels = [];
  List<List<String>> listImage = [];
  int indexImage = 0;
  int amountInt = 1;
  String? currentIdSeller;

  @override
  void initState() {
    // TODO: implement initState
    userModel = widget.userModel;
    readAPI();
    readCart();
  }

  Future<Null> readCart() async {
    await SQLiteHelper().readSQLite().then((value) {
      print('### value readCart == $value');
      if (value.length != 0) {
        List<SQLiteModel> models = [];
        for (var model in value) {
          models.add(model);
        }
        currentIdSeller = models[0].idSeller;
        print('### currentIdSeller = $currentIdSeller');
      }
    });
  }

  Future<Null> readAPI() async {
    String urlAPI =
        '${Myconstant.domain}/tu2hand/getProductWhereIdSeller.php?isAdd=true&idSeller=${userModel!.id}';
    await Dio().get(urlAPI).then(
      (value) {
        // print('#### value ===> $value');

        if (value.toString() == 'null') {
          setState(() {
            havePd = false;
            load = false;
          });
        } else {
          for (var item in json.decode(value.data)) {
            ProductModel model = ProductModel.fromMap(item);

            String string = model.imagesPd;
            string = string.substring(1, string.length - 1);
            List<String> strings = string.split(',');
            int i = 0;
            for (var item in strings) {
              strings[i] = item.trim();
              i++;
            }
            listImage.add(strings);

            setState(() {
              havePd = true;
              load = false;
              productModels.add(model);
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel!.name),
      ),
      body: load
          ? ShowProgress()
          : havePd!
              ? buildListProduct()
              : Center(
                  child: ShowTitle(
                    title: 'No Product!',
                    textStyle: Myconstant().h1Style(),
                  ),
                ),
    );
  }

  LayoutBuilder buildListProduct() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            //  print('Click ===> $index');
            showAlertDialog(productModels[index], listImage[index]);
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  width: constraints.maxWidth * 0.5 - 8,
                  height: constraints.maxWidth * 0.5 - 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: findUrlImage(productModels[index].imagesPd),
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) =>
                          showImage(path: Myconstant.image1),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.5,
                      height: constraints.maxWidth * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShowTitle(
                              title: productModels[index].namePd,
                              textStyle: Myconstant().h2Style(),
                            ),
                            ShowTitle(
                              title:
                                  'Price = ${productModels[index].pricePd} THB',
                              textStyle: Myconstant().h3Style(),
                            ),
                            ShowTitle(
                              title: cutWord(
                                  'Detail : ${productModels[index].detailPd}'),
                              textStyle: Myconstant().h3Style(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strs = string.split(',');
    int index = 0;
    for (var item in strs) {
      strs[index] = item.trim();
      index++;
    }
    String result = '${Myconstant.domain}/tu2hand${strs[0]}';
    //print('######## result ===> $result');
    return result;
  }

  Future<Null> showAlertDialog(
      ProductModel productModel, List<String> images) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  buildImageDetail(productModel, images, setState),
            ));
  }

  AlertDialog buildImageDetail(
      ProductModel productModel, List<String> images, StateSetter setState) {
    return AlertDialog(
      title: ListTile(
        leading: showImage(path: Myconstant.image1),
        title: ShowTitle(
          title: productModel.namePd,
          textStyle: Myconstant().h2Style(),
        ),
        subtitle: ShowTitle(
          title: 'Price = ${productModel.pricePd} THB',
          textStyle: Myconstant().h3Style(),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: '${Myconstant.domain}/tu2hand${images[indexImage]}',
              placeholder: (context, url) => ShowProgress(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexImage = 0;
                        print('### indexImage = $indexImage');
                      });
                    },
                    icon: Icon(Icons.filter_1),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexImage = 1;
                        print('### indexImage = $indexImage');
                      });
                    },
                    icon: Icon(Icons.filter_2),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexImage = 2;
                        print('### indexImage = $indexImage');
                      });
                    },
                    icon: Icon(Icons.filter_3),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexImage = 3;
                        print('### indexImage = $indexImage');
                      });
                    },
                    icon: Icon(Icons.filter_4),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ShowTitle(
                    title: 'รายละเอียด : ', textStyle: Myconstant().h2Style()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: ShowTitle(
                        title: productModel.detailPd,
                        textStyle: Myconstant().h3Style()),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    if (amountInt != 1) {
                      setState(() {
                        amountInt--;
                      });
                    }
                  },

                  icon: Icon(Icons.remove_circle_outline),
                  //color: Myconstant.dark,
                ),
                ShowTitle(
                  title: amountInt.toString(),
                  textStyle: Myconstant().h1Style(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      amountInt++;
                    });
                  },
                  icon: Icon(Icons.add_circle_outline),
                  //color: Myconstant.dark,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () async {
                  String idSeller = userModel!.id;
                  String idPd = productModel.id;
                  String namePd = productModel.namePd;
                  String pricePd = productModel.pricePd;
                  String amountPd = amountInt.toString();
                  String sumPd = (int.parse(pricePd) * amountInt).toString();
                  
                  if ((currentIdSeller == idSeller) ||
                      (currentIdSeller == null)) {
                    SQLiteModel sqLiteModel = SQLiteModel(
                        idSeller: idSeller,
                        idPd: idPd,
                        name: namePd,
                        price: pricePd,
                        amount: amountPd,
                        sum: sumPd);
                    await SQLiteHelper()
                        .insertValueToSQLite(sqLiteModel)
                        .then((value) {
                      amountInt = 1;
                      Navigator.pop(context);
                    });
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    MyDialog().normalDialog(context, 'โปรดชำระสินค้า',
                        'จากร้านเดิมให้เสร็จสิ้นก่อนทำรายการถัดไป ');
                  }
                },
                child: Text(
                  'Add to cart',
                  style: Myconstant().h2BStyle(),
                )),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: Myconstant().h3RStyle(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String cutWord(String string) {
    String result = string;
    if (result.length >= 100) {
      result = result.substring(0, 100);
      result = '$result ...';
    }
    return result;
  }
}
