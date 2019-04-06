import 'package:flutter/material.dart';
import '../util/database_item_client.dart';

class CategoryItem extends StatelessWidget {
  static const String keyItemName = "category_item_name";
  static const String keyDateCreated = "date_created";
  static const String keyItemDone = "category_item_done";
  static const String keyCategoryNr = "category_nr";
  static const String keyId = "id";

  String _categoryItemName;
  String _dateCreated;
  int _categoryItemDone = 0;
  int _categoryNr;
  int _id;

  CategoryItem(this._categoryItemName, this._dateCreated, this._categoryNr);

  CategoryItem.map(dynamic obj) {
    this._categoryItemName = obj[keyItemName];
    this._dateCreated = obj[keyDateCreated];
    this._categoryItemDone = obj[keyItemDone];
    this._categoryNr = obj[keyCategoryNr];
    this._id = obj[keyId];
  }

  String get categoryItemName => _categoryItemName;

  String get dateCreated => _dateCreated;

  int get categoryItemDone => _categoryItemDone;

  int get categoryNr => _categoryNr;

  int get id => _id;

  void set categoryItemDone(int val) {
    _categoryItemDone = val;
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map[keyItemName] = _categoryItemName;
    map[keyDateCreated] = _dateCreated;
    map[keyItemDone] = _categoryItemDone;
    map[keyCategoryNr] = _categoryNr;
    if (_id != null) {
      map[keyId] = _id;
    }
    return map;
  }

  CategoryItem.fromMap(Map<String, dynamic> map) {
    this._categoryItemName = map[keyItemName];
    this._dateCreated = map[keyDateCreated];
    this._categoryItemDone = map[keyItemDone];
    this._categoryNr = map[keyCategoryNr];
    this._id = map[keyId];
  }

  void deleteCategoryItem(int id) async {
    DatabaseItemHelper db = new DatabaseItemHelper();
    int rowsDeleted = await db.deleteItem(id);
    print(rowsDeleted);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _categoryItemName,
                style: _categoryItemDone == 0
                    ? TextStyle(
                        color: Colors.black,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      )
                    : TextStyle(
                        color: Colors.purple,
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
