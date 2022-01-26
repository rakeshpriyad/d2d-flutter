import 'package:d2d_flutter/models/ShippingAddress.dart';
import 'package:d2d_flutter/services/apiService.dart';
import 'package:d2d_flutter/services/storageService.dart';

class ShippingAddressServices {
  ApiService apiService = ApiService();
  StorageService storageService = StorageService();

  Future<List<ShippingAddress>> getShippingAddresses(String userName) async {
    return await apiService.loadAndParseShippingAddresses(userName);
  }

  loadAddresses() async {
    String userName = "rakesh";
    return getShippingAddresses(userName);
  }
}
