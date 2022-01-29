import 'package:d2d_flutter/models/CartItemPrice.dart';
import 'package:d2d_flutter/models/CartItemQuantity.dart';
import 'package:d2d_flutter/models/OrderItemPrice.dart';
import 'package:d2d_flutter/models/OrderItemQuantity.dart';

class OrderItem {
  String? id;
  String name;
  String description;
  String imageName;
  String itemId;
  String customerId;
  String orderId;
  OrderItemQuantity? quantity;
  OrderItemPrice? price;

  OrderItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageName,
      required this.itemId,
      required this.quantity,
      required this.price,
      required this.orderId,
      required this.customerId});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageName: json['imageName'],
        itemId: json['itemId'],
        quantity: json['quantity'] !=null ? OrderItemQuantity.fromJson(json['quantity']): null,
        price: json['price'] !=null ? OrderItemPrice.fromJson(json['price']) : null,
        orderId: json['orderId'],
        customerId: json['customerId']);
  }
}
