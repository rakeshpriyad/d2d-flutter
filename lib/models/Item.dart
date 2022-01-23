import 'package:d2d_flutter/models/ItemPrice.dart';
import 'package:d2d_flutter/models/ItemQuantity.dart';

class Item {
  String id;
  String name;
  String description;
  String itemCode;
  String productId;
  bool available = false;
  String imageName;
  ItemQuantity quantity;
  ItemPrice price;
  //String region;
  //String regionVariant;
  //ProductResponse product;


//  LocalDateTime purchaseDate;
//  LocalDateTime saleDate;


  Item(
      {
      required this.id,
      required this.name,
      required this.description,
      required this.itemCode,
      required this.productId,
      required this.available,
      required this.imageName,
      required this.quantity,
      required this.price
      });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      itemCode: json['itemCode'],
      productId: json['productId'],
      available: json['available'],
      imageName: json['imageName'],
      quantity: ItemQuantity.fromJson(json['quantity']),
      price: ItemPrice.fromJson(json['price'])
    );
  }
}
