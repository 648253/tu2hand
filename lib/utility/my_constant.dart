import 'package:flutter/material.dart';

class Myconstant {
  // General
  static String appName = 'TU2HAND';
  static String domain =
      'https://e4a8-2405-9800-bc02-2945-91a4-df6b-b54f-def.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSellerService = '/sellerService';
  static String routeSellerServiceAddPd = '/addProduct';

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String image6 = 'images/image6.png';
  static String image7 = 'images/image7.png';
  static String avatar = 'images/avatar.png';

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
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2WStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3WStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: Myconstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
