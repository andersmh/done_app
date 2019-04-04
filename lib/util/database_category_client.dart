import 'dart:io';

import '../model/category.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperCategory {
  static final DatabaseHelperCategory _instance =
      new DatabaseHelperCategory.internal();

  factory DatabaseHelperCategory() => _instance;

  final String tableName = "category";
  final String columnId = "id";
  final String columnCategoryName = "categoryName";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelperCategory.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "categorydb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print(documentDirectory);
    print(path);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnCategoryName TEXT)");
  }

  Future<int> saveCategory(Category category) async {
    var dbClient = await db;
    int res = await dbClient.insert("category", category.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllCategorys() async {
    var dbClient = await db;
    return await dbClient.query(tableName);
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('''
          SELECT COUNT(*) FROM $tableName ORDER BY $columnCategoryName ASC
        '''));
  }

  Future<Category> getCategory(int id) async {
    var dbClient = await db;
    List<Map> res = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (res.length == 0) return null;
    return new Category.fromMap(res.first);
  }

  Future<int> deleteCategory(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("$tableName", where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateCategory(Category category) async {
    var dbClient = await db;
    return await dbClient.update(tableName, category.toMap(),
        where: "$columnId = ?", whereArgs: [category.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
