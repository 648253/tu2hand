import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class BankWallet extends StatefulWidget {
  const BankWallet({Key? key}) : super(key: key);

  @override
  _BankWalletState createState() => _BankWalletState();
}

class _BankWalletState extends State<BankWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTitle(),
          buildKtbBank(),
          buildKBank(),
        ],
      ),
    );
  }

  Widget buildKtbBank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 100,
      child: Center(
        child: Card(
          color: Colors.blue.shade100,
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/ktb.svg'),
              ),
            ),
            title: ShowTitle(
                title: 'ธ.กรุงไทย สาขา :  ม.ธรรมศาสตร์',
                textStyle: Myconstant().h2Style()),
            subtitle: ShowTitle(
                title: 'ชื่อบัญชี : ซูฮัยล์ เปาะเตะ เลขบัญชี : 4753290530',
                textStyle: Myconstant().h3Style()),
            trailing: IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: '4753290530'),
                );
              },
              icon: Icon(Icons.copy),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKBank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 100,
      child: Center(
        child: Card(
          color: Colors.green.shade100,
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/kbank.svg'),
              ),
            ),
            title: ShowTitle(
                title: 'ธ.กสิกรไทย สาขา :  ม.ธรรมศาสตร์',
                textStyle: Myconstant().h2Style()),
            subtitle: ShowTitle(
                title: 'ชื่อบัญชี : ซูฮัยล์ เปาะเตะ เลขบัญชี : 4753290530',
                textStyle: Myconstant().h3Style()),
            trailing: IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: '4753290530'),
                );
              },
              icon: Icon(Icons.copy),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
          title: 'โอนเงินเข้า บัญชีธนาคาร', textStyle: Myconstant().h1Style()),
    );
  }
}
