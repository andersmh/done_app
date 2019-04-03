import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  String _itemName;
  int _id;

  Item(this._itemName);

  Item.map(dynamic obj) {
    this._itemName = obj["itemName"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = this._itemName;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._id = map["id"];
  }

  String get itemName => _itemName;

  set itemName(String value) {
    _itemName = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _itemName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
