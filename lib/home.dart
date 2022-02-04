import 'package:d2d_flutter/widgets/BottomNavigationBarWidget.dart';
import 'package:d2d_flutter/widgets/ListBottomWidget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  int selectedPosition = 0;
  Function? superSetState;
  List<Widget>? listBottomWidget;

  Home(List<Widget>? listBottomWidget, Function? superSetState,
      int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
    this.listBottomWidget = listBottomWidget;
  }

  @override
  _HomeState createState() =>
      _HomeState(listBottomWidget, superSetState, selectedPosition);
}

class _HomeState extends State<Home> {
  int selectedPosition = 0;
  Function? superSetState;
  List<Widget>? listBottomWidget;

  _HomeState(List<Widget>? listBottomWidget, Function? superSetState,
      int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
    this.listBottomWidget = listBottomWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBarWidget(
        superSetState,
        selectedPosition,
      ),
      body: ListBottomWidget(
        listBottomWidget: this.listBottomWidget!,
        selectedPosition: selectedPosition,
      ),
    );
  }
}
