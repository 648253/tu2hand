import 'package:flutter/material.dart';
import 'package:myfirstpro/bodys/show_manage_seller.dart';
import 'package:myfirstpro/bodys/show_order_seller.dart';
import 'package:myfirstpro/bodys/show_product_seller.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_signout.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShowMangeSeller(),
    ShowProductSeller()
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Myconstant.dark,
        title: Text('Seller'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShopManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งซื้อลูกค้า',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }

  ListTile menuShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'Show Manage',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดหน้าร้าน',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: Myconstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดสินค้า',
        textStyle: Myconstant().h3Style(),
      ),
    );
  }
}
