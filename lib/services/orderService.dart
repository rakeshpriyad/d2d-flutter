import 'package:d2d_flutter/models/Order.dart';
import 'package:d2d_flutter/models/ShippingAddress.dart';
import 'package:d2d_flutter/services/apiService.dart';
import 'package:d2d_flutter/services/storageService.dart';

class OrderService {
  ApiService apiService = ApiService();
  StorageService storageService = StorageService();

  Future<Order> createCODOrderandGetOrderDetails(String userName, String addressId) async {
    return await apiService.createOrderCOD(userName, addressId);
  }

  createCODOrder(String userName, String addressId) async {
   // String userName = "rakesh";
    return createCODOrderandGetOrderDetails(userName, addressId);
  }
}
