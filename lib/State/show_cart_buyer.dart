import 'package:flutter/material.dart';
import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:myfirstpro/utility/sqlite_helper.dart';

class ShowCartBuyer extends StatefulWidget {
  const ShowCartBuyer({Key? key}) : super(key: key);

  @override
  _ShowCartBuyerState createState() => _ShowCartBuyerState();
}

class _ShowCartBuyerState extends State<ShowCartBuyer> {
  List<SQLiteModel> sqliteModels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    await SQLiteHelper().readSQLite().then((value) {
      setState(() {
        sqliteModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
    );
  }
}
