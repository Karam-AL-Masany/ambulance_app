import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class ConnectSqlite {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "ambulance_categories.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int version) {
    print("upgrade");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "categories" (
    "id" INTEGER PRIMARY KEY NOT NULL ,
    "name" TEXT NOT NULL  )
    ''');

    await db.execute('''
    CREATE TABLE "photos" (
    "id" INTEGER PRIMARY KEY NOT NULL ,
    "id_invoice" INTEGER NOT NULL ,
    "imgPath" TEXT NOT NULL )
    ''');

    print("create database and table");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  myDeleteDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ambulance_categories.db');
    print("deleted");
    await deleteDatabase(path);
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

}
