import 'package:flutter/material.dart';
import '../util/database_item_client.dart';

class Item extends StatelessWidget {
  static const String keyItemName = "item_name";
  static const String keyDateCreated = "date_created";
  static const String keyItemDone = "item_done";
  static const String keyId = "id";

  String _itemName;
  String _dateCreated;
  int _itemDone = 0;
  int _id;

  Item(this._itemName, this._dateCreated);

  Item.map(dynamic obj) {
    this._itemName = obj[keyItemName];
    this._dateCreated = obj[keyDateCreated];
    this._itemDone = obj[keyItemDone];
    this._id = obj[keyId];
  }

  String get itemName => _itemName;

  String get dateCreated => _dateCreated;

  int get itemDone => _itemDone;

  int get id => _id;

  void set itemDone(int val) {
    _itemDone = val;
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map[keyItemName] = _itemName;
    map[keyDateCreated] = _dateCreated;
    map[keyItemDone] = _itemDone;
    if (_id != null) {
      map[keyId] = _id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._itemName = map[keyItemName];
    this._dateCreated = map[keyDateCreated];
    this._itemDone = map[keyItemDone];
    this._id = map[keyId];
  }

  void deleteItem(int id) async {
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
                _itemName,
                style: _itemDone == 0
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
