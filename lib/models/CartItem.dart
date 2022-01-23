import 'package:d2d_flutter/models/CartItemPrice.dart';
import 'package:d2d_flutter/models/CartItemQuantity.dart';

class CartItem {
  String? id;
  String name;
  String description;
  String itemCode;
  bool available = false;
  String imageName;
  String itemId;
  CartItemQuantity quantity;
  CartItemPrice price;
  String userName;

  CartItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.itemCode,
      required this.itemId,
      required this.available,
      required this.imageName,
      required this.quantity,
      required this.price,
      required this.userName});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        itemCode: json['itemCode'],
        itemId: json['productId'],
        available: json['available'],
        imageName: json['imageName'],
        quantity: CartItemQuantity.fromJson(json['quantity']),
        price: CartItemPrice.fromJson(json['price']),
        userName: json['userName']);
  }
}
