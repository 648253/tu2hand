import 'package:flutter/material.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class ShowMangeSeller extends StatefulWidget {
  final UserModel userModel;
  const ShowMangeSeller({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowMangeSellerState createState() => _ShowMangeSellerState();
}

class _ShowMangeSellerState extends State<ShowMangeSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowTitle(title: 'Name Shop : ', textStyle: Myconstant().h2Style()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShowTitle(
                    title: userModel!.name, textStyle: Myconstant().h1Style()),
              ),
            ],
          ),
          ShowTitle(title: 'Address : ', textStyle: Myconstant().h2Style()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShowTitle(
                    title: userModel!.address,
                    textStyle: Myconstant().h2Style(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
