
class ShippingAddress {
  String id;
  String mobileNo;
  String address1;
  String address2;
  String address3;
  String cityId;
  String stateId;
  String countryId;
  String? landMark;
  String zipCode;
  String? addressTypeId;
  String? state;
  String? country;
  String? city;

  String userId;

  ShippingAddress(
      {required this.id,
      required this.mobileNo,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.cityId,
      required this.stateId,
      required this.countryId,
      required this.zipCode,
      required this.userId});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
        id: json['id'],
        mobileNo: json['mobileNo'],
        address1: json['address1'],
        address2: json['address2'],
        address3: json['address3'],
        cityId: json['cityId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        zipCode: json['zipCode'],
        userId: json['userId']);
  }
}
