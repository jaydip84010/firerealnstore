import 'package:firedemo/usermodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'usermodel.dart';

class DatabaseHelper {
  Database? db;

  DatabaseHelper._();

  static final DatabaseHelper databaseHelper = DatabaseHelper._();
  String Table =
      'CREATE TABLE LOG (id INTEGER PRIMARY KEY, name TEXT,mobilenumber INTEGER,password TEXT)';

  Future<Database?>get database async {
    if (db != null) {
      return db;
    } else {
      db = await createdatabase();
      return db;
    }
  }

  createdatabase() async {
    var databasepath = await getDatabasesPath();
    var path = join(databasepath, "mydata.db");
   return await openDatabase(path,version: 1, onCreate: (Database database, int version) async {
     await database.execute(Table);
    });
  }

  insert(Usermodel usermodel) async {
    final db = await database;
    var result = await db?.insert('LOG', usermodel.tomap());
    return result;
  }

  getdata() async {
    List<Usermodel> detail = [];
    final db = await database;
    var result = await db?.rawQuery("SELECT * FROM LOG");
    if(result != null && result.isNotEmpty){
      result.forEach((element) {
        Usermodel data=Usermodel.frommap(element);
        detail.add(data);
      });
    }
    return detail;
  }


  updatedata(Usermodel usermodel, int id) async{

    final db= await database;
    var result= await db?.update('LOG',usermodel.tomap(),where:'id=?',whereArgs: [id]);
    return result;
  }

  delete(int id)async{
    final db=await database;

    var result= await db?.delete('LOG',where:'id= ?',whereArgs: [id]);
  }
}
