import 'package:flutter/material.dart';
import '../util/database_item_client.dart';

class Item extends StatelessWidget {
  static const String keyItemName = "item_name";
  static const String keyDateCreated = "date_created";
  static const String keyId = "id";

  String _itemName;
  String _dateCreated;
  int _id;

  Item(this._itemName, this._dateCreated);

  Item.map(dynamic obj) {
    this._itemName = obj[keyItemName];
    this._dateCreated = obj[keyDateCreated];
    this._id = obj[keyId];
  }

  String get itemName => _itemName;

  String get dateCreated => _dateCreated;

  int get id => _id;

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map[keyItemName] = _itemName;
    map[keyDateCreated] = _dateCreated;
    if (_id != null) {
      map[keyId] = _id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._itemName = map[keyItemName];
    this._dateCreated = map[keyDateCreated];
    this._id = map[keyId];
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
                _itemName,
                style: TextStyle(
                  color: Colors.black,
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

  void deleteItem(int id) async {
    DatabaseItemHelper db = new DatabaseItemHelper();
    int rowsDeleted = await db.deleteItem(id);
    print(rowsDeleted);
  }
}

/*
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
                _itemName,
                style: TextStyle(
                  color: Colors.black,
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

*/
