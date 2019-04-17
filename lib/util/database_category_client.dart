import 'dart:io';
import '../model/category.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'database_category_item_client.dart';

/*
  Auther: Anders Mæhlum Halvorsen
*/

class DatabaseCategoryHelper {
  final String tableName = "table_category";
  final String columnId = "id";
  static const String columnCategoryName = "category_name";

  static final DatabaseCategoryHelper _instance =
      new DatabaseCategoryHelper.internal();
  static DatabaseCategoryItemHelper dcih = new DatabaseCategoryItemHelper();
  factory DatabaseCategoryHelper() => _instance;
  static Database _db;

  Future<Database> get getDb async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseCategoryHelper.internal();

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "cat_db.db");
    var dbCreated = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbCreated;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableName("
          "$columnId INTEGER PRIMARY KEY, "
          "$columnCategoryName TEXT);",
    );
  }

  Future<int> saveCategory(Category category) async {
    var dbClient = await getDb;
    int rowsSaved = await dbClient.insert(tableName, category.toMap());
    return rowsSaved;
  }

  Future<List> getCategorys() async {
    var dbClient = await getDb;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnCategoryName ASC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await getDb;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM $tableName"));
  }

  Future<Category> getCategory(int categoryId) async {
    var dbClient = await getDb;
    var category = await dbClient
        .rawQuery("SELECT * FROM ${tableName} WHERE $columnId=$categoryId");
    if (category.length == 0) return null;
    return new Category.fromMap(category.first);
  }

  Future<int> deleteCategory(int id) async {
    var db = await getDb;
    await dcih.initDb();
    await dcih.deleteAllCategoryItems(id);
    int rowsDeleted =
        await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
    return rowsDeleted;
  }

  Future<int> updateCategory(Category category) async {
    int id = category.id;
    print("id of the category is $id");
    var db = await getDb;
    int rowsUpdated = await db.update("$tableName", category.toMap(),
        where: "$columnId  = ?", whereArgs: [category.id]);
    return rowsUpdated;
  }

  Future close() async {
    var dbClient = await getDb;
    dbClient.close();
  }
}
