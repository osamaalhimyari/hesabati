// ignore: depend_on_referenced_packages
// ignore_for_file: camel_case_types, avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  //to call the database and check if it is exist or not
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    // method create new data base
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'hesab.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    // print("upgrade===============================");
    await db.execute('');
//to upgrade the database
  }

  _onCreate(Database db, int version) async {
    // the command of sql
    // ? AUTOINCREMENT  are puted in the last to avoid errors

    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE "notes"(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        note TEXT NOT NULL,
        title TEXT,
        color text
      )
''');
    batch.execute('''
      CREATE TABLE "user"(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        number TEXT,
        email TEXT, 
        locked BIT,
        password TEXT,
        imagePath TEXT
      )
''');

    batch.execute('''
      CREATE TABLE "people"(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        title TEXT,
        number TEXT,
        email TEXT,
        imagePath TEXT,
        pin BIT,
        dateAdding DATE NOT NULL,
        dateModify DATE NOT NULL

      )
''');
//this table for recording money state type=type of taking money lending or debt
    batch.execute('''
      CREATE TABLE "document"(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        idUser INTEGER NOT NULL,
        money int NOT NULL,
        give_take text,
        type   INTEGER,
        descripton TEXT,
        currency TEXT,
        IconSine BIT,

        dateAdding DATE ,
        dateModify DATE 
      )
''');

    await batch.commit();

//     await db.execute('''
//       CREATE TABLE "notes"(
//         id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//         note TEXT NOT NULL
//       )
// ''');

//  CREATE TABLE "agents"(
//         id INTEGER NOT NULL PRIMARY KEY,
//         name TEXT NOT NULL,
//         job  TEXT ,
//         imageUrl TEXT ,
//         pin BIT
//       )
    print("create ======================");
  }

// the above code create the database
  fetchData(String table) async {
    // this method fetch data from data base
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insertData(String table, Map<String, Object?> values) async {
    // this method insert to data from data base
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  updatehData(
      String table, Map<String, Object?> values, String? myWhere) async {
    // this method update data from data base
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: myWhere);
    return response;
  }

  deletData(String table, String? myWhere) async {
    // this method delet data from data base
    Database? mydb = await db;
    var response = await mydb!.delete(table, where: myWhere);
    return response;
  }

  deleteMyDataBase() async {
    // this method delete database
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hesab.db');
    return deleteDatabase(path);
  }

  customFetch(String table, int id) async {
    Database? mydb = await db;
    List<Map> res = await mydb!.rawQuery('SELECT * FROM $table WHERE id=$id');

    return res;
  }

  customUpdate(String sql) async {
    Database? mydb = await db;
    int res = await mydb!.rawUpdate(sql);
    return res;
  }

  count(String table) async {
    // this method fetch data from data base
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('''SELECT id FROM $table
WHERE id=(SELECT MAX(id) from $table)''');
    int r = response.first['id'];
    return r;
  }

  ///
}

class people {
  // const people(key key );

  late int id = 0;
  late String name = "name";
  late String title;
  late String number;
  late String email;
  late String imagePath;
  late bool pin;
  late String dateAdding;
  late String dateModify;
}
