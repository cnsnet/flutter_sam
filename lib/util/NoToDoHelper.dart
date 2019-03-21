import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Database/NoDoItem.dart';

class NoToDoDBHelper {
  final String tableName="notodo";
  final String itemName="itemName";
  final String dateCreated="dateCreated";
  final String identifyer="id";
  static final NoToDoDBHelper _instance = new NoToDoDBHelper.internal();

  factory NoToDoDBHelper() => _instance;

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();

      return _db;
    }
  }

  NoToDoDBHelper.internal();

  Future<Database> initDb() async {
    var _databasePath = await getDatabasesPath();
    String _path = join(_databasePath, "notodo.db");

    return await openDatabase(_path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($identifyer INTEGER PRIMARY KEY,$itemName TEXT, $dateCreated TEXT)");
  }

  Future<int> save(NoDoItem item) async {
    var dbClient = await db;

    int result=await dbClient.insert("$tableName", item.toMap());

    return result;
  }

  Future<List> getAll() async{
    var dbClient=await db;

    var result=dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $itemName ASC");

    return result;
  }

  Future<int> getCount() async{
    var dbClient=await db;

    //var result=dbClient.query("SELECT * FROM $tableName");
    var result=Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName")
    );

    return result;
  }

  Future<NoDoItem> getModel(int id) async{
    var dbClient=await db;

    var result=await dbClient.rawQuery("SELECT * FROM $tableName WHERE $identifyer=$id");

    if(result.length==0) return null;
    else return NoDoItem.fromMap(result.first);
  }

  Future<int> deleteModel(int id) async{
    var dbClient=await db;

    return await dbClient.delete("$tableName",where:"$identifyer=?",whereArgs: [id]);
  }

  Future<int> updateModel(NoDoItem item) async{
    var dbClient=await db;

    return await dbClient.update("$tableName", item.toMap(),where: "$identifyer=?",whereArgs: [item.id]);
  }

  Future closeDB() async{
    var dbClient=await db;

    dbClient.close();
  }
}
