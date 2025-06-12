import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuotesDb{
  static Database? _database;
  Future<Database?>get database async{
    if(_database==null){
      return _database=await initDb();
  }else{
      return _database;
  }
}


  initDb()async{
    String dbpath=await getDatabasesPath();
    String path=join(dbpath,'quotes.db');
    Database database=await openDatabase(path,onCreate:_onCreate );
    return database;
  }
  _onCreate (Database database,int version)async{
    await database.execute('''
    CREATE TABLE user_quotes (
    quote_id INTEGER PRIMARY KEY AUTOINCREMENT , 
    quote_text TEXT NOT NULL,
    author TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
    )
    '''
    );
    await database.execute('''
    CREATE TABLE users(
    user_id INTEGER PRIMARY KEY AUTOINCREMENT ,
    user_name TEXT NOT NULL,
    password_hash TEXT NOT NULL
    )
    ''');
if (kDebugMode) {
  print('========================Database Created');
}
  }

  readData(String sql)async{
    Database? db=await database;
    List<Map> response=await db!.rawQuery(sql);
    if (kDebugMode) {
      print('selected Done');
    }
    return response;

  }
  insertData(String sql)async{
    Database? db=await database;
    int response=await db!.rawInsert(sql);
    if (kDebugMode) {
      print('insert Done');
    }
    return response;
  }
 updateData(String sql)async{
    Database? db=await database;
    int response=await db!.rawUpdate(sql);
    if (kDebugMode) {
      print('update Done');
    }
    return response;
  }
  deleteData(String sql)async{
    Database? db=await database;
    int response=await db!.rawDelete(sql);
    if (kDebugMode) {
      print('deleted Done');
    }
    return response;
  }


}
