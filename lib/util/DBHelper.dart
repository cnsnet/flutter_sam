import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Models.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();

      return _db;
    }
  }

  DBHelper.internal();

  Future<Database> initDb() async {
    var _databasePath = await getDatabasesPath();
    String _path = join(_databasePath, "data.db");

    return await openDatabase(_path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY,username TEXT, password TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;

    int result=await dbClient.insert("users", user.toMap());

    return result;
  }

  Future<List> getAllUsers() async{
    var dbClient=await db;

    var result=dbClient.rawQuery("SELECT * FROM users");

    return result;
  }

  Future<int> getCount() async{
    var dbClient=await db;

    //var result=dbClient.query("SELECT * FROM users");
    var result=Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM users")
    );

    return result;
  }

  Future<User> getUser(int id) async{
    var dbClient=await db;

    var result=await dbClient.rawQuery("SELECT * FROM USERS WHERE id=$id");

    if(result.length==0) return null;
    else return User.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async{
    var dbClient=await db;

    return await dbClient.delete("users",where:"id=?",whereArgs: [id]);
  }

  Future<int> updateUser(User user) async{
    var dbClient=await db;

    return await dbClient.update("users", user.toMap(),where: "id=?",whereArgs: [user.id]);
  }

  Future closeDB() async{
    var dbClient=await db;

    dbClient.close();
  }
}
