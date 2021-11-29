import 'package:myfirstpro/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDb = 'tu2hand.db';
  final int version = 1;
  final String tableDb = 'tableOrder';
  final String columnId = 'id';
  final String columnIdSeller = 'idSeller';
  final String columnIdPd = 'idPd';
  final String columnIdName = 'name';
  final String columnIdPrice = 'price';
  final String columnIdAmount = 'amount';
  final String columnIdSum = 'sum';

  SQLiteHelper() {
    initialDb();
  }

  Future<Null> initialDb() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDb),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDb ($columnId INTEGER PRIMARY KEY, $columnIdSeller TEXT, $columnIdPd TEXT, $columnIdName TEXT, $columnIdPrice TEXT, $columnIdAmount TEXT, $columnIdSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDb() async {
    return await openDatabase(join(await getDatabasesPath(), nameDb));
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database database = await connectedDb();
    List<SQLiteModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDb);
    print('### maps SQLiteHelper ===>>> $maps');
    for (var item in maps) {
      SQLiteModel model = SQLiteModel.fromMap(item);
      results.add(model);
    }

    return results;
  }
}
