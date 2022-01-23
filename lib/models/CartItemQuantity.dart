import 'package:d2d_flutter/models/ItemQuantityType.dart';
import 'package:d2d_flutter/models/ItemQuantityUnit.dart';

class CartItemQuantity {
  double? totalQuantity;
  double? discountedQuantity;
  double? unitQuantity;
  int count = 0;

  String quantityType;
  String unit;

  CartItemQuantity({
    required this.totalQuantity,
    required this.count,
    required this.unitQuantity,
    required this.quantityType,
    required this.unit,
    required this.discountedQuantity,
  });

  factory CartItemQuantity.fromJson(Map<String, dynamic> json) {
    return CartItemQuantity(
      totalQuantity: json['totalQuantity'],
      unitQuantity: json['unitQuantity'],
      discountedQuantity: json['discountedQuantity'],
      count: json['count'],
      quantityType: json['quantityType'],
      unit: json['unit'],
    );
  }
}
