import 'package:flutter/material.dart';
import 'package:myfirstpro/State/add_wallet.dart';
import 'package:myfirstpro/State/authen.dart';
import 'package:myfirstpro/State/buyer_service.dart';
import 'package:myfirstpro/State/create_account.dart';
import 'package:myfirstpro/State/seller_edit_profile.dart';
import 'package:myfirstpro/State/seller_service.dart';
import 'package:myfirstpro/State/seller_service_addpd.dart';
import 'package:myfirstpro/State/show_cart_buyer.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/sellerService': (BuildContext context) => SellerService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfile': (BuildContext context) => SellerEditProfile(),
  '/showCartBuyer': (BuildContext context) => ShowCartBuyer(),
  '/addWallet':(BuildContext context) => AddWallet(),
};

String? initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ทำส่วนนี้ให้จบก่อนเริ่มเเรก ensureInitialized
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ==> $type');
  if (type?.isEmpty ?? true) {
    // ถ้า null มาหน้าเเรกสุด
    initialRoute = Myconstant.routeAuthen;
    runApp(MyApp());
  } else {
    // ถ้ามี login ค้างไว้ให้มานี้
    switch (type) {
      case 'buyer':
        initialRoute = Myconstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initialRoute = Myconstant.routeSellerService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xffb61825, Myconstant.mapMaterialColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Myconstant.appName,
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
