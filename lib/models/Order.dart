import 'package:d2d_flutter/models/CartItemPrice.dart';
import 'package:d2d_flutter/models/CartItemQuantity.dart';
import 'package:d2d_flutter/models/OrderItem.dart';

class Order {
  String? id;
  String name;
  String description;
  String status;
  String? orderCode;
  String? resultStatus;
  String? resultMsg;
  String? txnToken;
  String orderStatus;
  double totalOrderAmount;
  String customerId;
  String shippingAddress;
  List<OrderItem> orderItems = [];

  Order(
      {required this.id,
      required this.name,
      required this.description,
      required this.status,
      required this.orderStatus,
      required this.totalOrderAmount,
      required this.shippingAddress,
      required this.orderItems,
      required this.customerId});

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];
    var orderItemJson =json["orderItems"] as List<dynamic>;

    for (var i = 0; i < orderItemJson.length; i++) {
      Map<String, dynamic> map = orderItemJson[i];
      orderItems.add(OrderItem.fromJson(map));
    }

    return Order(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        status: json['status'],
        orderStatus: json['orderStatus'],
        totalOrderAmount: json['totalOrderAmount'],
        shippingAddress: json['shippingAddress'],
        orderItems : orderItems,
        customerId: json['customerId']);
  }
}
