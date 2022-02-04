import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  int selectedPosition = 0;
  Function? superSetState;

  BottomNavigationBarWidget(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomNavigationBar();
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), title: Text("Search")),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Cart")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("Account")),
      ],
      currentIndex: this.selectedPosition,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey.shade100,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      onTap: (position) {
        this.superSetState!(position);
      },
    );
  }
}
