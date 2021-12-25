import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/State/seller_edit_product.dart';
import 'package:myfirstpro/models/product_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;
  bool? haveData;
  List<ProductModel> productModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    if (productModels.length != 0) {
      productModels.clear();
    } else {}

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String apiGetProductWhereSeller =
        '${Myconstant.domain}/tu2hand/getProductWhereSeller.php?isAdd=true&idSeller=$id';
    await Dio().get(apiGetProductWhereSeller).then((value) {
      if (value.toString() == 'null') {
        //No Data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        //Have Data
        for (var item in json.decode(value.data)) {
          ProductModel model = ProductModel.fromMap(item);
          print('Name Product ==>> ${model.namePd}');

          setState(() {
            load = false;
            haveData = true;
            productModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : haveData!
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                        title: 'No Product',
                        textStyle: Myconstant().h1Style(),
                      ),
                      ShowTitle(
                        title: 'Please Add Product',
                        textStyle: Myconstant().h1Style(),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Myconstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, Myconstant.routeSellerServiceAddPd)
                .then((value) => loadValueFromAPI()),
        child: ShowTitle(title: 'เพิ่ม',textStyle: Myconstant().h2WStyle(),),
      ),
    );
  }

  String createUrl(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> strings = result.split(',');
    String url = '${Myconstant.domain}/tu2hand${strings[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: constraints.maxWidth * 0.5 - 4,
              height: constraints.maxWidth * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowTitle(
                      title: productModels[index].namePd,
                      textStyle: Myconstant().h2Style()),
                  Container(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxWidth * 0.3,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: createUrl(productModels[index].imagesPd),
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) =>
                          showImage(path: Myconstant.image1),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(4),
              width: constraints.maxWidth * 0.5 - 4,
              height: constraints.maxWidth * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                      title: 'ราคา ฿${Myconstant().moneyFormat(productModels[index].pricePd)} ',
                      textStyle: Myconstant().h2Style()),
                  ShowTitle(
                      title: cutWord(productModels[index].detailPd),
                      textStyle: Myconstant().h3Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          print('## Click Edit');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerEditProduct(productModel: productModels[index],),
                              )).then((value) => loadValueFromAPI());
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 36,
                          color: Myconstant.dark,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('## You Click Delete form index = $index');
                          confirmDialogDelete(productModels[index]);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          size: 36,
                          color: Myconstant.dark,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> confirmDialogDelete(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: CachedNetworkImage(
            imageUrl: createUrl(productModel.imagesPd),
            placeholder: (context, url) => ShowProgress(),
          ),
          title: ShowTitle(
            title: 'Delete ${productModel.namePd}?',
            textStyle: Myconstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: productModel.detailPd,
            textStyle: Myconstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              print('## Confirm Delete at id ==> ${productModel.id}');
              String apiDeleteProductWhereId =
                  '${Myconstant.domain}/tu2hand/deleteProductWhereId.php?isAdd=true&id=${productModel.id}';
              await Dio().get(apiDeleteProductWhereId).then((value) {
                Navigator.pop(context);
                loadValueFromAPI();
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  cutWord(String detailPd) {
    String result = detailPd;
    if (result.length >= 100) {
      result = result.substring(0, 100);
      result = '$result ...';
    }
    return result;
  }
}
