
class OrderItemQuantity {
  double? totalQuantity;
  double? discountedQuantity;
  double? unitQuantity;
  int count = 0;

  String quantityType;
  String unit;


  OrderItemQuantity(
      {
      required this.totalQuantity,
      required this.count,
      required this.unitQuantity,
      required this.quantityType,
      required this.unit,
      required this.discountedQuantity,

      });

  factory OrderItemQuantity.fromJson(Map<String, dynamic> json) {

    return OrderItemQuantity(
      totalQuantity: json['totalQuantity'],
      unitQuantity: json['unitQuantity'],
      discountedQuantity: json['discountedQuantity'],
      count: json['count'],
      quantityType: json['quantityType'],
      unit: json['unit'],
    );
  }
}
