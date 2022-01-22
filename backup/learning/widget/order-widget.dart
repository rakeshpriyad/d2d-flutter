import 'package:d2d_flutter/dto/customer.dart';
import 'package:d2d_flutter/dto/order.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  Customer _customer;
  Order _order;
  OrderWidget(this._customer, this._order);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Order Info"),
        ),
        body: new Padding(
          padding: EdgeInsets.all(20.0),
          child: new ListView(
            children: <Widget>[
              Text(_customer.name,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              Text(_customer.location,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Text(""),
              Text(_order.description,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Text(
                  "${_order.dt.month}/${_order.dt.day}/${_order.dt.year}: "
                      "\$${_order.total}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
            ],
          ),
        ));
  }
}