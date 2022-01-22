class Item {
  String id;
  String name;
  String description;
  String itemCode;
  String productId;
  bool available = false;
  String imageName;
  //String region;
  //String regionVariant;
  //ProductResponse product;
//  ItemQuantity quantity;
//  ItemPrice price;
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
      required this.imageName

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
    );
  }
}
