import 'package:flutter/material.dart';
import 'package:myfirstpro/bodys/my_money.dart';
import 'package:myfirstpro/bodys/my_order.dart';
import 'package:myfirstpro/bodys/show_all_shop_buyer.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_signout.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidgets = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Myconstant.routeBuyerShowCart),
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidgets],
    );
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.storefront,
        size: 36,
        color: Myconstant.dark,
      ),
      title:
          ShowTitle(title: 'Show All Shop', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงร้านค้าทั้งหมด', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.account_balance_wallet_outlined,
        size: 36,
        color: Myconstant.dark,
      ),
      title: ShowTitle(title: 'MyMoney', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงจำนวนเงินทั้งหมด', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag_outlined,
        size: 36,
        color: Myconstant.dark,
      ),
      title: ShowTitle(title: 'MyOrder', textStyle: Myconstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงรายการสั่งซ์้อ', textStyle: Myconstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
