import 'package:flutter/material.dart';

import '../util/date_formatter.dart';
import '../model/category.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      body: Column(children: <Widget>[
        Container(
          color: Color(0xFF020E38),
          child: Container(
            height: 140.0,
            width: 1000,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius:
                  new BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Text(
                "Tasks.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 70,
                  fontFamily: 'Futura',
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Color(0xFF020E38),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
            ),
          ),
        )
      ]),
    );
  }
}
