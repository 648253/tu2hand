import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDb = 'tu2hand.db';
  final int version = 1;
  final String tableDb = 'tableOrder';
  final String columnId = 'id';
  final String columnIdSeller = 'idSeller';
  final String columnIdNameSeller = 'nameSeller';
  final String columnIdPd = 'idPd';
  final String columnIdName = 'name';
  final String columnIdPrice = 'price';
  final String columnIdAmount = 'amount';
  final String columnIdSum = 'sum';

  var phone;

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDb),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDb ($columnId INTEGER PRIMARY KEY, $columnIdSeller TEXT, $columnIdNameSeller TEXT, $columnIdPd TEXT, $columnIdName TEXT, $columnIdPrice TEXT, $columnIdAmount TEXT, $columnIdSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDb));
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database database = await connectedDatabase();
    List<SQLiteModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDb);
    // print('### maps on SQLitHelper ==>> $maps');
    for (var item in maps) {
      SQLiteModel model = SQLiteModel.fromMap(item);
      results.add(model);
    }
    //print('#### $results');
    return results;
  }

  Future<Null> insertValueToSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();

    await database.insert(tableDb, sqLiteModel.toMap());

    //print('${sqLiteModel}');
  }

  Future<Null> updateValueToSQLite(
      SQLiteModel sqLiteModel, String sumPd, String amountPd, String id) async {
    Database database = await connectedDatabase();

    await database.rawUpdate(
        "UPDATE `tableOrder` SET `sum` = '$sumPd' , `amount` = '$amountPd' WHERE idPd = '$id'");
    readSQLite();
  }

  Future<void> deleteSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    await database
        .delete(tableDb, where: '$columnId = $id')
        .then((value) => print('### Success Delete id ==> $id'));
  }

  Future<void> emptySQLite() async {
    Database database = await connectedDatabase();
    await database
        .delete(tableDb)
        .then((value) => print('### Empty SQLite Success'));
  }

  Future<Null> clearSQLite() async {
    await SQLiteHelper().emptySQLite().then((value) {
      readSQLite();
    });
  }
}
