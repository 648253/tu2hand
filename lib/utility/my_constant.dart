import 'package:flutter/material.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class Myconstant {
  // General
  static String appName = 'TU2HAND';
  static String domain =
      'https://457e-2405-9800-bc02-2945-3565-6ad7-7af0-e8c3.ngrok.io';
  static String urlQRcode = 'https://promptpay.io/0612019351.png';

  String keyId = 'id';
  String keyType = 'type';
  String keyName = 'name';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSellerService = '/sellerService';
  static String routeSellerServiceAddPd = '/addProduct';
  static String routeSellerEditProfile = '/editProfile';
  static String routeBuyerShowCart = '/showCartBuyer';
  static String routeAddWallet = '/addWallet';

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String image6 = 'images/image6.png';
  static String image7 = 'images/image7.png';
  static String image8 = 'images/image8.jpg';
  static String image9 = 'images/image9.jpg';
  static String avatar = 'images/avatar.png';
  static String promtpayImg = 'images/promptpay.png';

  //Color
  static Color primary = Color(0xffef534e);
  static Color dark = Color(0xffb61825);
  static Color light = Color(0xffff867a);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 182, 24, 0.1),
    100: Color.fromRGBO(255, 182, 24, 0.2),
    200: Color.fromRGBO(255, 182, 24, 0.3),
    300: Color.fromRGBO(255, 182, 24, 0.4),
    400: Color.fromRGBO(255, 182, 24, 0.5),
    500: Color.fromRGBO(255, 182, 24, 0.6),
    600: Color.fromRGBO(255, 182, 24, 0.7),
    700: Color.fromRGBO(255, 182, 24, 0.8),
    800: Color.fromRGBO(255, 182, 24, 0.9),
    900: Color.fromRGBO(255, 182, 24, 1),
  };

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h1WStyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
  TextStyle h1BStyle() => TextStyle(
        fontSize: 24,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2BlStyle() => TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2WStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3RStyle() => TextStyle(
        fontSize: 14,
        color: Colors.red.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2BStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2BlaStyle() => TextStyle(
        fontSize: 18,
        color: Colors.black38,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2GStyle() => TextStyle(
        fontSize: 18,
        color: Colors.green,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3BStyle() => TextStyle(
        fontSize: 14,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      );

  TextStyle h3WStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: Myconstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  List<String> changeToArrays(String string) {
    List<String> list = [];
    String str = string.substring(1, string.length - 1);
    print('my string ==> $str');
    list = str.split(',');
    int index = 0;
    for (var str in list) {
      list[index] = str.trim();
      print('my string ==>$str, list[index] ==>${list[index]}');
      index++;
    }
    return list;
  }

  Widget buildHeadOrder() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.red.shade400),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ShowTitle(
              title: 'รายการสินค้า',
              textStyle: Myconstant().h3WStyle(),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildEmptyBlock() {
    return SizedBox(
      width: 12,
      height: 10,
    );
  }

  String moneyFormat(String price) {
    String value = price;
    if (price.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    }
    return value;
  }
}
