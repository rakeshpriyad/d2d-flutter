
class InvoiceQuantity {
  double? totalQuantity;
  double? discountedQuantity;
  double? unitQuantity;
  int count = 0;

  String quantityType;
  String unit;


  InvoiceQuantity(
      {
      required this.totalQuantity,
      required this.count,
      required this.unitQuantity,
      required this.quantityType,
      required this.unit,
      required this.discountedQuantity,

      });

  factory InvoiceQuantity.fromJson(Map<String, dynamic> json) {

    return InvoiceQuantity(
      totalQuantity: json['totalQuantity'],
      unitQuantity: json['unitQuantity'],
      discountedQuantity: json['discountedQuantity'],
      count: json['count'],
      quantityType: json['quantityType'],
      unit: json['unit'],
    );
  }
}
