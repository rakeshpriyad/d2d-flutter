import 'package:d2d_flutter/home.dart';
import 'package:d2d_flutter/pages/CartPage.dart';
import 'package:d2d_flutter/pages/HomePage.dart';
import 'package:d2d_flutter/pages/ProfilePage.dart';
import 'package:d2d_flutter/pages/SearchPage.dart';
import 'package:flutter/material.dart';

class BaseHome extends StatefulWidget {
  @override
  _BaseHomeState createState() => _BaseHomeState();
}

class _BaseHomeState extends State<BaseHome> {
  int selectedPosition = 0;
  List<Widget> listBottomWidget = [];

  void changeTab(position) {
    setState(() {
      selectedPosition = position;
      print("position: $position");
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => Home(listBottomWidget, changeTab, position)));
    });
  }

  @override
  void initState() {
    super.initState();
    addHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Home(listBottomWidget, changeTab, 0);
  }

  void addHomePage() {
    listBottomWidget.add(HomePage(changeTab, selectedPosition));
    listBottomWidget.add(SearchPage());
    listBottomWidget.add(CartPage(changeTab, selectedPosition));
    listBottomWidget.add(ProfilePage());
  }
}
