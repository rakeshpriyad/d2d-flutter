import 'package:d2d_flutter/models/InvoicePrice.dart';
import 'package:d2d_flutter/models/InvoiceQuantity.dart';


class InvoiceLineItem {
  final String id;
  final String name;
  final String description;
  final String itemId;
  final DateTime date;
  final InvoiceQuantity quantity;
//  final double vat;
  final InvoicePrice price;

  const InvoiceLineItem({
    required this.id,
    required this.name,
    required this.description,
    required this.itemId,
    required this.date,
    required this.quantity,
    //required this.vat,
    required this.price,
  });

  factory InvoiceLineItem.fromJson(Map<String, dynamic> json) {
    return InvoiceLineItem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        itemId: json['itemCode'],
        date: json['date'],
        quantity: InvoiceQuantity.fromJson(json['quantity']),
        price: InvoicePrice.fromJson(json['price'])
    );
  }
}
