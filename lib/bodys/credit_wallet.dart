import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/utility/sqlite_helper.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditWallet extends StatefulWidget {
  const CreditWallet({Key? key}) : super(key: key);

  @override
  _CreditWalletState createState() => _CreditWalletState();
}

class _CreditWalletState extends State<CreditWallet> {
  List<SQLiteModel> sqliteModels = [];
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: buildTitle('Name'),
                  ),
                  Expanded(
                    child: buildTitle('Surname'),
                  ),
                ],
              ),
              buildNameSurname(),
              buildTitle('ID Card: '),
              buildIDCard(),
              buildExpireCVC(),
              buildTitle('Amount: '),
              buildAmount(),
              buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Center buildAddButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text('Add'),
        ),
      ),
    );
  }

  Container buildExpireCVC() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizeBox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expire Date: '),
                buildFormExpireDate(),
              ],
            ),
          ),
          buildSizeBox(10),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC: '),
                buildFormCVC(),
              ],
            ),
          ),
          buildSizeBox(30),
        ],
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizeBox(30),
          buildFormName(),
          buildSizeBox(10),
          buildFormSurname(),
          buildSizeBox(30),
        ],
      ),
    );
  }

  Widget buildAmount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffix: ShowTitle(title: 'THB.'),
            label: ShowTitle(title: 'Amount :'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );

  Widget buildFormExpireDate() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xx/xx',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );

  Widget buildFormCVC() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxx',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );

  Widget buildFormName() => Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            label: ShowTitle(title: 'Name: '),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );

  Widget buildFormSurname() => Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            label: ShowTitle(title: 'Surname: '),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );

  Widget buildIDCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'XXXX - XXXX - XXXX - XXXX ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );

  Widget buildTitle(String str) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShowTitle(
          title: str,
          textStyle: Myconstant().h2Style(),
        ),
      );

  SizedBox buildSizeBox(double width) => SizedBox(
        width: width,
      );

}
