import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PleaseWaitWidget extends StatelessWidget {
  PleaseWaitWidget({
    required Key key,
  }) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        color: Colors.white.withOpacity(0.8));
  }
}
