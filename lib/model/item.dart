import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;

  Item(this._itemName, this._dateCreated);

  Item.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = this._itemName;
    map["dateCreated"] = this._dateCreated;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._dateCreated = map["dateCreated"];
    this._itemName = map["itemName"];
    this._id = map["id"];
  }

  String get itemName {
    _itemName;
  }

  set itemName(String value) {
    _itemName = value;
  }

  String get dateCreated => _dateCreated;

  set dateCreated(String value) {
    _dateCreated = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
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
}
