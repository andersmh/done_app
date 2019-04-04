import 'package:flutter/material.dart';
import 'item.dart';

class Category extends StatelessWidget {
  String _categoryName;
  List<Item> _itemList = <Item>[];
  int _id;

  Category(this._categoryName);

  Category.map(dynamic obj) {
    this._categoryName = obj["itemName"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = this._categoryName;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this._categoryName = map["itemName"];
    this._id = map["id"];
  }

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _categoryName,
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
