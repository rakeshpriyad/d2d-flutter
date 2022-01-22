import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/services/itemService.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  ItemServices itemServices = ItemServices();
  List<Item> items = [];
  List<Item> cartItems = [];
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    //super.onInit();
    loadDB();
  }

  loadDB() async {
   // await itemServices.openDB();
    loadItems();
    getCardList();
  }

  getItem(String id) {
    return items.singleWhere((element) => element.id == id);
  }

  bool isAlreadyInCart(id) {
    return cartItems.indexWhere((element) => element.id == id) > -1;
  }

  getCardList() async{
    try {
      List list = await itemServices.getCartList();
      cartItems.clear();
      list.forEach((element) {
        cartItems.add(Item.fromJson(element));
      });
      update();

    } catch (e) {
      print(e);
    }
  }

  loadItems()async{
    try {
      isLoading = true;
      update();

      items = await itemServices.loadItems();
      /*list.forEach((element) {
        items.add(ShopItemModel.fromJson(element));
      });*/

      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  setToFav(int id, bool flag) async {
    int index = items.indexWhere((element) => element.id == id);

   // items[index].fav = flag;
    update();
    try {
      await itemServices.setItemAsFavourite(id, flag);
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(Item item) async {
    isLoading = true;
    update();
    var result = await itemServices.addToCart(item);
    isLoading = false;
    update();
    return result;
  }

  removeFromCart(String id) async {
    itemServices.removeFromCart(id);
    int index = cartItems.indexWhere((element) => element.id == id);
    cartItems.removeAt(index);
    update();
  }
}