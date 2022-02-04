import 'package:flutter/material.dart';

class ListBottomWidget extends StatelessWidget {
  const ListBottomWidget({
    Key? key,
    required this.listBottomWidget,
    required this.selectedPosition,
  }) : super(key: key);

  final List<Widget> listBottomWidget;
  final int selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return listBottomWidget[selectedPosition];
    });
  }
}