import 'package:flutter/material.dart';
import 'package:myfirstpro/bodys/bank_wallet.dart';
import 'package:myfirstpro/bodys/credit_wallet.dart';
import 'package:myfirstpro/bodys/promtpay_wallet.dart';
import 'package:myfirstpro/utility/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    BankWallet(),
    PromtpayWallet(),
    CreditWallet(),
  ];
  List<IconData> icons = [
    Icons.money_outlined,
    Icons.payment_outlined,
    Icons.card_membership,
  ];

  List<String> titles = [
    'Bank',
    'Promtpay',
    'Credit',
  ];

  int indexPos = 0;

  List<BottomNavigationBarItem> bottomNavigatorBarItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0; 
    for (var item in titles) {
      bottomNavigatorBarItems.add(
        createBottomNavigationBarItem(icons[i], item),
      );
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
    IconData iconData,
    String string,
  ) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet from ${titles[indexPos]}'),
      ),
      body: widgets[indexPos],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPos,
        selectedItemColor: Myconstant.dark,
        items: bottomNavigatorBarItems,
        onTap: (value) {
          setState(() {
            indexPos = value;
          });
        },
      ),
    );
  }
}
