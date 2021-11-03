import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Show Product!'),
      floatingActionButton: FloatingActionButton(backgroundColor: Myconstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, Myconstant.routeSellerServiceAddPd),
            child: Text('+'),
      ),
    );
  }
}
