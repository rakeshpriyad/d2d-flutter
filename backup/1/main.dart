import 'package:d2d_flutter/cartmodel.dart';
import 'package:d2d_flutter/cartpage.dart';
import 'package:d2d_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp(
    model: CartModel(),
  ));


class MyApp extends StatelessWidget{

  final CartModel model;

  const MyApp({ required this.model}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<CartModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        home: HomePage(),
        routes: {'/cart': (context) => CartPage()},
      ),
    );
  }
}