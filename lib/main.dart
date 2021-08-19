import 'package:flutter/material.dart';
import 'package:myfirstpro/State/authen.dart';
import 'package:myfirstpro/State/buyer_service.dart';
import 'package:myfirstpro/State/create_account.dart';
import 'package:myfirstpro/State/seller_service.dart';
import 'package:myfirstpro/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/sellerService': (BuildContext context) => SellerService(),
};

String? initialRoute;

void main() {
  initialRoute = Myconstant.routeAuthen;
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Myconstant.appname,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
