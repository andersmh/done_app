import 'dart:io';

import '../model/item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = "nodo";
  final String columnId = "id";
  final String columnItemName = "itemName";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print(documentDirectory);
    print(path);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnItemName TEXT)");
  }

  Future<int> saveItem(Item item) async {
    var dbClient = await db;
    int res = await dbClient.insert("nodo", item.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    var dbClient = await db;
    return await dbClient.query(tableName);
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('''
          SELECT COUNT(*) FROM $tableName ORDER BY $columnItemName ASC
        '''));
  }

  Future<Item> getItem(int id) async {
    var dbClient = await db;
    List<Map> res = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (res.length == 0) return null;
    return new Item.fromMap(res.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("$tableName", where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItem(Item item) async {
    var dbClient = await db;
    return await dbClient.update(tableName, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
