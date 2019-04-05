import 'package:flutter/material.dart';
import '../util/database_category_client.dart';

class Category extends StatelessWidget {
  static const String keyCategoryName = "category_name";
  static const String keyId = "id";

  String _categoryName;
  int _id;

  Category(this._categoryName);

  Category.map(dynamic obj) {
    this._categoryName = obj[keyCategoryName];

    this._id = obj[keyId];
  }

  String get categoryName => _categoryName;

  int get id => _id;

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map[keyCategoryName] = _categoryName;
    if (_id != null) {
      map[keyId] = _id;
    }
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this._categoryName = map[keyCategoryName];
    this._id = map[keyId];
  }

  void deleteCategory(int id) async {
    DatabaseCategoryHelper db = new DatabaseCategoryHelper();
    int rowsDeleted = await db.deleteCategory(id);
    print(rowsDeleted);
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

/*
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
*/
