import 'package:flutter/material.dart';
import '../ui/homeContent.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Tasks.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 60,
            fontFamily: 'Futura',
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: HomeContentPage(),
    );
  }
}
