import 'dart:async';
import 'dart:convert';
import 'package:d2d_flutter/models/Item.dart';
import 'package:http/http.dart' as HTTP;

class ApiService {
  //static final String _BASE_URL = "http://dummy.restapiexample.com/api/v1";
  static final String BASE_URL = "http://192.168.1.106:8080/d2d";
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

  Future getCartList() async {}

  Future addToCart(Item data) async {}

  Future removeFromCart(String shopId) async {}
}
