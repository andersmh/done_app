import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/category_item.dart';

/*
  Auther: Anders Mæhlum Halvorsen
*/

class DatabaseCategoryItemHelper {
  static const String tableName = "table_category_item";
  static const String columnId = "id";
  static const String columnCategoryItemName = "category_item_name";
  static const String columnDateCreated = "date_created";
  static const String columnCategoryNr = "category_nr";
  static const String columnCategoryItemDone = "category_item_done";

  static final DatabaseCategoryItemHelper _instance =
      new DatabaseCategoryItemHelper.internal();

  factory DatabaseCategoryItemHelper() => _instance;
  static Database _db;

  Future<Database> get getDb async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseCategoryItemHelper.internal();

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "category_item_db.db");
    var dbCreated = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbCreated;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableName("
        "$columnId INTEGER PRIMARY KEY, "
        "$columnCategoryItemName TEXT, "
        "$columnDateCreated TEXT,"
        "$columnCategoryItemDone INTEGER,"
        "$columnCategoryNr INTEGER);");
  }

  Future<int> saveCategoryItem(CategoryItem categoryItem) async {
    var dbClient = await getDb;
    int rowsSaved = await dbClient.insert(tableName, categoryItem.toMap());
    return rowsSaved;
  }

  Future<List> getCategoryItems(int categoryNr) async {
    var dbClient = await getDb;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableName WHERE $columnCategoryNr=$categoryNr ORDER BY $columnCategoryItemDone ASC");
    return result.toList();
  }

  Future<int> getCount(int categoryNr) async {
    var dbClient = await getDb;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT (*) FROM $tableName WHERE $columnCategoryNr=$categoryNr"));
  }

  Future<int> getDoneCount(int categoryNr) async {
    var dbClient = await getDb;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT (*) FROM $tableName WHERE $columnCategoryNr=$categoryNr AND $columnCategoryItemDone=1"));
  }

  Future<CategoryItem> getCategoryItem(int itemId) async {
    var dbClient = await getDb;
    var item = await dbClient
        .rawQuery("SELECT * FROM ${tableName} WHERE $columnId=$itemId");
    if (item.length == 0) return null;
    return new CategoryItem.fromMap(item.first);
  }

  Future<int> deleteCategoryItem(int id) async {
    var db = await getDb;
    int rowsDeleted =
        await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
    return rowsDeleted;
  }

  Future<int> updateCategoryItem(CategoryItem item) async {
    int id = item.id;
    print("id of the item is $id");
    var db = await getDb;
    int rowsUpdated = await db.update("$tableName", item.toMap(),
        where: "$columnId  = ?", whereArgs: [item.id]);
    return rowsUpdated;
  }

  Future close() async {
    var dbClient = await getDb;
    dbClient.close();
  }
}
