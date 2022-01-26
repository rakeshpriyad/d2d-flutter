
import 'package:d2d_flutter/models/CartItem.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/services/apiService.dart';
import 'package:d2d_flutter/services/storageService.dart';

class CartItemService {
  ApiService apiService = ApiService();
  StorageService storageService = StorageService();

  Future<List<Item>> getShoppingItems() async {
    return await apiService.loadAndParseShopItemModels();
  }

  loadItems() async {
    return getShoppingItems();
  }

  Future<bool> isFirstTime() async {
    return await storageService.getItem("isFirstTime") == 'true';
  }

  Future setItemAsFavourite(id, flag) async {
    return await apiService.setItemAsFavourite(id, flag);
  }

  Future addToCart(CartItem data) async {
    return await apiService.addToCart(data);
  }

  Future getCartList() async {
    return await apiService.getCartList();
  }

  removeFromCart(String id) async {
    return await apiService.removeFromCart(id);
  }
}
