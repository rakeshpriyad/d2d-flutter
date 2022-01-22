import 'package:d2d_flutter/dto/customer.dart';
import 'package:d2d_flutter/dto/order.dart';
import 'package:d2d_flutter/widget/order-widget.dart';
import 'package:flutter/material.dart';

class CustomerWidget extends StatelessWidget {
  Customer _customer;
  CustomerWidget(this._customer);
  void navigateToOrder(BuildContext context, Customer customer, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderWidget(customer, order)),
    );
  }
  ListTile createOrderListWidget(
      BuildContext context, Customer customer, Order order) {
    return new ListTile(
        title: Text(order.description),
        subtitle: Text("${order.dt.month}/${order.dt.day}/${order.dt.year}: "
            "\$${order.total}"),
        trailing: Icon(Icons.arrow_right),
        onTap: () => navigateToOrder(context, customer, order));
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List.from(_customer.orders.map(
            (Order order) => createOrderListWidget(context, _customer, order)));
    widgetList.insert(
        0,
        Container(
            child: Column(
              children: <Widget>[
                Text(
                  _customer.name,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  _customer.location,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_customer.orders.length} Orders",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            padding: EdgeInsets.all(20.0)));
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Customer Info"),
        ),
        body: new Center(
          child: new ListView(
            children: widgetList,
          ),
        ));
  }
}
