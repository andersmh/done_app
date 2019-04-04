import 'package:flutter/material.dart';
import 'item.dart';

class Category extends StatelessWidget {
  String _categoryName;
  List<Item> _itemList = <Item>[];
  int _id;

  Category(this._categoryName);

  Category.map(dynamic obj) {
    this._categoryName = obj["categoryName"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["categoryName"] = this._categoryName;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this._categoryName = map["categoryName"];
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
      width: 250.0,
      height: 250.0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: DecoratedBox(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: new LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomCenter,
            colors: [
              const Color(0xff007ECE),
              const Color(0xffC418F7),
            ],
          ),
        ),
        child: Center(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Text(
                  _categoryName,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
