import 'dart:async';
import 'dart:convert';
import 'package:d2d_flutter/models/CartItem.dart';
import 'package:d2d_flutter/models/Invoice.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/models/Order.dart';
import 'package:d2d_flutter/models/ShippingAddress.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:d2d_flutter/utils/http_exception.dart';
import 'package:http/http.dart' as HTTP;

class ApiService {
  static final String BASE_URL =
      ApiConst.BASE_URL; //"http://10.0.2.2:8080/d2d";

  static const _TIMEOUT = Duration(seconds: 10);

  fetchData(String url) async {
    return await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
  }

  Future<List<Item>> loadAndParseShopItemModels() async {
    var url = '${BASE_URL}/items';
    List<Item> listItems = [];
    try {
      final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body) as List<dynamic>;
        print(parsed);
        for (var i = 0; i < parsed.length; i++) {
          Map<String, dynamic> map = parsed[i];
          listItems.add(Item.fromJson(map));
        }
      }
    } catch (e) {
      throw e;
    }
    return listItems;
  }

  Future saveRecord(Item data) async {}

  Future setItemAsFavourite(int id, bool flag) async {}

  Future getItemsRecord() async {}

  Future getCartList() async {
    var url = '${BASE_URL}/cart/items/rakesh';
    List<CartItem> listCartItems = [];
    try {
      final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body) as List<dynamic>;
        print(parsed);
        for (var i = 0; i < parsed.length; i++) {
          Map<String, dynamic> map = parsed[i];
          listCartItems.add(CartItem.fromJson(map));
        }
      }
    } catch (e) {
      throw e;
    }
    return listCartItems;
  }

  Future addToCart(CartItem data) async {
    var url = '${BASE_URL}/cart/add';
    String? inStock = "true";
    if (data.available != null) {
      inStock = "true";
    } else {
      inStock = "false";
    }
    var postData = jsonEncode(<String, String>{
      'id': "",
      'name': data.name,
      'description': data.description,
      'itemCode': data.itemCode,
      'available': inStock,
      'imageName': data.imageName,
      'itemId': data.itemId,
      'quantity': "{}",
      'price': "{}",
      'userName': data.userName
    });

    final response = await HTTP
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
          },
          body: postData,
        )
        .timeout(_TIMEOUT);
    final responseData = jsonDecode(response.body)
        as List<dynamic>; //json.decode(response.body);
    print(responseData);
    /*  if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }*/

    //return response;
  }

  Future removeFromCart(String shopId) async {}

  Future<List<ShippingAddress>> loadAndParseShippingAddresses(
      String userName) async {
    var baseUrl = ApiConst.SHIPPING_BASE_URL;

    var url = '${baseUrl}/${userName}';
    List<ShippingAddress> listAddress = [];
    try {
      final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body) as List<dynamic>;
        // print(parsed);
        for (var i = 0; i < parsed.length; i++) {
          Map<String, dynamic> map = parsed[i];
          listAddress.add(ShippingAddress.fromJson(map));
        }
      }
    } catch (e) {
      throw e;
    }
    return listAddress;
  }

  Future<Order> createOrderCOD(String userName, String addressId) async {
    var url = '${ApiConst.COD_ORDER_BASE_URL}';
    var postData = jsonEncode(<String, String>{
      'id': "",
      'name': "",
      'description': "",
      'status': "CREATED",
      'totalOrderAmount': "0",
      'shippingAddressId': addressId,
      'userName': "rakesh",
    });

    final response = await HTTP
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
          },
          body: postData,
        )
        .timeout(_TIMEOUT);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    Order order = Order.fromJson(responseData);
    print(responseData);
    return order;
  }

  Future<Invoice> loadInvoice(String orderId) async {
    var baseUrl = ApiConst.INVOICE_BASE_URL;
    Invoice? invoice = null;
    var url = '${baseUrl}/${orderId}';
    try {
      final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body) as Map<String, dynamic>;
        print(parsed);

        invoice = Invoice.fromJson(parsed);
      }
    } catch (e) {
      throw e;
    }
    return invoice!;
  }
}
