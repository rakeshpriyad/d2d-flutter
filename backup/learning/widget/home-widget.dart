import 'dart:async';
import 'dart:convert';

import 'package:d2d_flutter/dto/customer.dart';
import 'package:d2d_flutter/dto/order.dart';
import 'package:d2d_flutter/widget/customer-widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageWidget extends StatelessWidget {
  Future<List<Order>> fetchOrders() async {
    String URL ="http://dummy.restapiexample.com/api/v1/employees";
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Order> orders  = List.empty();
      return orders;
    } else {
      // badStatusCode(response);
      throw Exception('Failed to load employee');
    }
  }
  //List<Order> orderList = fetchOrders();
  List<Customer> _customerList = [
    Customer("Bike Corp", "Atlanta", [
      Order(DateTime(2018, 11, 17), "Bicycle parts", 197.02),
      Order(DateTime(2018, 12, 1), "Bicycle parts", 107.45),
    ]),
    Customer("Trust Corp", "Atlanta", [
      Order(DateTime(2017, 1, 3), "Shredder parts", 97.02),
      Order(DateTime(2018, 3, 13), "Shredder blade", 7.45),
      Order(DateTime(2018, 5, 2), "Shredder blade", 7.45),
    ]),
    Customer("Jilly Boutique", "Birmingham", [
      Order(DateTime(2018, 1, 3), "Display unit", 97.01),
      Order(DateTime(2018, 3, 3), "Desk unit", 12.25),
      Order(DateTime(2018, 3, 21), "Clothes rack", 97.15),
    ]),
  ];
  HomePageWidget({Key? key}) : super(key: key);
  /*HomePageWidget({Key? key}) : super(key: key){
   this.fetchOrders();
  }*/

  void navigateToCustomer(BuildContext context, Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerWidget(customer)),
    );
  }

  ListTile createCustomerWidget(BuildContext context, Customer customer) {
    return new ListTile(
        title: Text(customer.name),
        subtitle: Text(customer.location),
        trailing: Icon(Icons.arrow_right),
        onTap: () => navigateToCustomer(context, customer));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> customerList = List.from(_customerList
        .map((Customer customer) => createCustomerWidget(context, customer)));
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("D2D Items"),
        ),
        body: new Center(
          child: new ListView(
            children: customerList,
          ),
        ));
  }
}
