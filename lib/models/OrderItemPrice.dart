
class OrderItemPrice {
  double? totalPrice;
  double unitPrice;

  double discountedPrice;

  String? type;

  bool? defaultPrice = false;

//  LocalDateTime specialPriceStartDate;

  //LocalDateTime specialPriceEndDate;

  double? specialPrice;

  double? discountPercentage;


  OrderItemPrice(
      {
      required this.totalPrice,
      required this.unitPrice,
      required this.discountedPrice,
      required this.type,
      required this.defaultPrice,
      required this.specialPrice,
      required this.discountPercentage

      });

  factory OrderItemPrice.fromJson(Map<String, dynamic> json) {

    return OrderItemPrice(
      totalPrice: json['totalPrice'],
      unitPrice: json['unitPrice'],
      discountedPrice: json['discountedPrice'],
      type: json['type'],
      defaultPrice: json['defaultPrice'],
      specialPrice: json['specialPrice'],
      discountPercentage: json['discountPercentage'],
    );
  }
}
