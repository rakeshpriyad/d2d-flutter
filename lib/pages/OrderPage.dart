import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/models/Order.dart';
import 'package:d2d_flutter/pages/CartPage.dart';
import 'package:d2d_flutter/pages/ItemDetailPage.dart';
import 'package:d2d_flutter/pages/OrderItemPage.dart';
import 'package:d2d_flutter/services/itemService.dart';
import 'package:d2d_flutter/utils/CustomTextStyle.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  Order? order;

  OrderPage(Order order) {
    this.order = order;
  }

  @override
  _OrderPageState createState() => _OrderPageState(order);
}

class _OrderPageState extends State<OrderPage> {
  Order? order;

  _OrderPageState(Order? order) {
    this.order = order;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Back"),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkResponse(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: Stack(
                    children: [
                      GetBuilder<HomePageController>(
                          builder: (_) => Align(
                                child: Text(''),
                                alignment: Alignment.topLeft,
                              )),
                      Align(
                        child: Icon(Icons.shopping_cart),
                        alignment: Alignment.center,
                      ),
                    ],
                  )),
            )
          ],
        ),
        body: Container(
          child: GetBuilder<HomePageController>(
            //init: controller,
            builder: (_) => OrderCard(
              order: this.order!,
            ),
          ),
        ));
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    List<Order> orderList = [];
    orderList.add(order);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: orderList.map((o) => OrderView(order: this.order)).toList(),
        ));
  }
}

class OrderView extends StatelessWidget {
  final Order order;
  static final String BASE_URL = ApiConst.IMG_BASE_URL;

  OrderView({required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: InkResponse(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderItemPage(order.orderItems)));
          },
          child: Material(
            child: Container(
                height: 380.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Order Id:${order.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Name:${order.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Description:${order.description}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),*/
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Status: ${order.orderStatus}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "Total Order Amount:${order.totalOrderAmount}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => OrderItemPage(order.orderItems)));
                      },
                      color: Colors.green,
                      padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Text(
                        "Order Details",
                        style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
