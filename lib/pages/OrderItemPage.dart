import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/OrderItem.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItemPage extends StatelessWidget {
  static final String BASE_URL = ApiConst.IMG_BASE_URL;
  List<OrderItem> orderItems = [];

  OrderItemPage(List<OrderItem> orderItems) {
    this.orderItems = orderItems;
  }

  Widget generateOrderItem(BuildContext context, OrderItem orderItem) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1.0),
              top: BorderSide(color: Colors.grey.shade100, width: 1.0),
            )),
        height: 100.0,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5.0)
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  image: DecorationImage(
                      image: NetworkImage(BASE_URL), // + orderItem.imageName),
                      fit: BoxFit.fitHeight)),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          orderItem.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Price  ₹${orderItem.price?.unitPrice}"),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order list"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: GetBuilder<HomePageController>(
                builder: (_) {
                  if (this.orderItems.length == 0) {
                    return Center(
                      child: Text("No item found"),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: this
                        .orderItems
                        .map((d) => generateOrderItem(context, d))
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
