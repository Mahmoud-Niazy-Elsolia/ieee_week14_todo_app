import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDb {
  static Database? _database ;

  Future<Database?> get database async{
    if(_database == null){
      _database = await init();
      return _database;
    }
    else{
      return _database;
    }
  }


  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return database;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE 'tasks' (id INTEGER PRIMARY KEY, title TEXT, date TEXT)");
    print('Created Successfully....');
  }

  Future<List<Map>> getData()async{
    Database? myDatabase = await database;
    List<Map> response = await myDatabase!.rawQuery("SELECT * FROM 'tasks'");
    return response;

  }

  Future<void> insertData({
    required String title,
    required String date,
})async{
    Database? myDatabase = await database;
     await myDatabase!.rawInsert("INSERT INTO 'tasks' ('title', 'date') VALUES('$title', '$date')");
  }
}
