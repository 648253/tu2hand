import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfirstpro/models/cart_model.dart';
import 'package:myfirstpro/models/order_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
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
  String? idBuyer;
  UserModel? userModel;
  List<CartModel> cartModels = [];
  List<String> listCartNameSellers = [];
  List<String> listCartNames = [];
  List<String> listCartPrices = [];
  List<String> listCartAmounts = [];
  List<String> listCartSums = [];
  List<String> listCartImgs = [];
  int? total;
  bool load = true;

//=======================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    findDetailSeller();
  }

//=======================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: load
          ? ShowProgress()
          : cartModels.isEmpty
              ? showHaveNoOrder()
              : SingleChildScrollView(child: buildContent()),
    );
  }

  Center showHaveNoOrder() {
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

//=======================================================

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
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Myconstant().buildEmptyBlock(),
          Card(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ShowTitle(
                  textStyle: Myconstant().h2BlStyle(),
                  title: 'Total :  ',
                ),
                SizedBox(
                  width: 10,
                ),
                ShowTitle(
                  title: '฿${Myconstant().moneyFormat((total.toString()))}',
                  textStyle: Myconstant().h1Style(),
                ),
                SizedBox(
                  width: 30,
                ),
                buttonController(),
              ],
            ),
          ),
          Myconstant().buildEmptyBlock(),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Row buttonController() {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightGreen,
          ),
          onPressed: () {
            sendCartToOrder();

            //Navigator.pushNamed(context, Myconstant.routeAddWallet);
          },
          child: Text('Order'),
        ),
        Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: ElevatedButton(
              onPressed: () => confirmEmptyCart(),
              child: Text('Clear'),
            )),
      ],
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: cartModels.length,
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
                          width: 80,
                          height: 80,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                '${Myconstant.domain}${cartModels[index].imgPd}',
                            placeholder: (context, url) => ShowProgress(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'ร้าน :  ${cartModels[index].nameSeller}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'สินค้า : ${cartModels[index].namePd}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    textStyle: Myconstant().h2BlStyle(),
                                    title:
                                        '฿${Myconstant().moneyFormat(cartModels[index].pricePd)}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ShowTitle(
                                    title:
                                        'จำนวน : x${cartModels[index].amountPd}'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      idBuyer = preferences.getString(Myconstant().keyId);
                      String id = cartModels[index].id;
                      String path =
                          '${Myconstant.domain}/tu2hand/deleteOrderWhereId.php?isAdd=true&id=$id&idBuyer=$idBuyer';
                      Dio().get(path).then((value) {
                        findDetailSeller();
                      });
                      print('### Delete id ===> $id');
                    },
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calTotal() async {
    total = 0;
    for (var item in cartModels) {
      int sumInt = int.parse(item.sumPd);
      setState(() {
        total = total! + sumInt;
      });
    }
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
        setState(() {
          load = false;
        });
      } else {
        for (var map in json.decode(value.data)) {
          CartModel cartModel = CartModel.fromMap(map);
          //print(cartModel);
          //  List<String> cartNamePd = cartModel.namePd;
          setState(() {
            load = false;
            cartModels.add(cartModel);
            listCartNameSellers.add(cartModel.nameSeller);
            listCartNames.add(cartModel.namePd);
            listCartPrices.add(cartModel.pricePd);
            listCartAmounts.add(cartModel.amountPd);
            listCartSums.add(cartModel.sumPd);
            listCartImgs.add(cartModel.imgPd);
            calTotal();
          });
        }
      }
    });
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
              String path =
                  '${Myconstant.domain}/tu2hand/deleteAllCartWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
              await Dio().get(path).then((value) {
                findDetailSeller();
                Navigator.pop(context);
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

  Future<void> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user')!;
    String apiGetUser =
        '${Myconstant.domain}/tu2hand/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiGetUser).then((value) {
      //print('value from api ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  Future<Null> sendCartToOrder() async {
    DateTime dateTimeOrder = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeOrder);
    String status = 'เตรียมสินค้า';
    for (var i = 0; i < cartModels.length; i++) {
      String path =
          '${Myconstant.domain}/tu2hand/insertOrderBuyer.php?isAdd=true&idSeller=${cartModels[i].idSeller}&idPd=${cartModels[i].idPd}&nameShop=${cartModels[i].nameSeller}&namePd=${cartModels[i].namePd}&pricePd=${cartModels[i].pricePd}&amountPd=${cartModels[i].amountPd}&sumPd=${cartModels[i].sumPd}&idBuyer=${cartModels[i].idBuyer}&nameBuyer=${userModel!.name}&addressBuyer=${userModel!.address}&phoneBuyer=${userModel!.phone}&dateTime=$dateTime&status=$status&imgPd=${cartModels[i].imgPd}';
      await Dio().get(path).then((value) => null);
    }
    String path =
        '${Myconstant.domain}/tu2hand/deleteAllCartWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(path).then((value) {
      Navigator.pop(context);
    });
  }
}
