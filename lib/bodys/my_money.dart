import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({Key? key}) : super(key: key);

  @override
  _MyMoneyBuyerState createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowTitle(
              title: 'เงินใน Wallet คุณมี',
              textStyle: Myconstant().h1Style(),
            ),
            
            ShowTitle(
              title: '฿${Myconstant().moneyFormat('1200')}',
              textStyle: Myconstant().h1Style(),
            ),
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Colors.red.shade600),
              onPressed: () {
                Navigator.pushNamed(context, Myconstant.routeAddWallet);
              },
              icon: Icon(Icons.monetization_on_outlined),
              label: Text('เติมเงิน')),
          ],
        ),
      ),
    );
  }
}
