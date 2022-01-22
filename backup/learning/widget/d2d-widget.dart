import 'package:flutter/material.dart';

import 'emp-list-widget.dart';


class D2DWidget extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'D2D',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*home: new HomePageWidget(),*/
      home: new EmployeeListWidget(),
    );
  }
}
