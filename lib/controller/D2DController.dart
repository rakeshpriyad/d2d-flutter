import 'package:d2d_flutter/models/CartItem.dart';
import 'package:d2d_flutter/models/CartItemPrice.dart';
import 'package:d2d_flutter/models/CartItemQuantity.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/models/ShippingAddress.dart';
import 'package:d2d_flutter/services/cartItemService.dart';
import 'package:d2d_flutter/services/itemService.dart';
import 'package:d2d_flutter/services/orderService.dart';
import 'package:d2d_flutter/services/shippingAddressService.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  ItemServices itemServices = ItemServices();
  CartItemService cartItemServices = CartItemService();
  OrderService orderService = OrderService();
  ShippingAddressServices addressServices = ShippingAddressServices();
  List<Item> items = [];
  List<CartItem> cartItems = [];
  List<ShippingAddress> addressList = [];
  bool isLoading = true;
  String selectedAddressId = "";

  @override
  void onInit() {
    loadDB();
  }

  loadDB() async {
    loadItems();
    getCartList();
    getShippingAddressList();
  }

  getItem(String id) {
    return items.singleWhere((element) => element.id == id);
  }

  bool isAlreadyInCart(id) {
    return cartItems.indexWhere((element) => element.id == id) > -1;
  }

  getCartList() async {
    try {
      cartItems = await cartItemServices.getCartList();
      update();
    } catch (e) {
      print(e);
    }
  }

  getShippingAddressList() async {
    try {
      addressList = await addressServices.loadAddresses();
      update();
    } catch (e) {
      print(e);
    }
  }

  loadItems() async {
    try {
      isLoading = true;
      update();
      items = await itemServices.loadItems();
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
    CartItemQuantity quantity = CartItemQuantity(
        totalQuantity: item.quantity.totalQuantity,
        count: item.quantity.count,
        unitQuantity: item.quantity.unitQuantity,
        quantityType: item.quantity.quantityType,
        unit: item.quantity.unit,
        discountedQuantity: item.quantity.discountedQuantity);
    CartItemPrice price = CartItemPrice(
        totalPrice: item.price.totalPrice,
        unitPrice: item.price.unitPrice,
        discountedPrice: item.price.discountedPrice,
        type: item.price.type,
        defaultPrice: item.price.defaultPrice,
        specialPrice: item.price.specialPrice,
        discountPercentage: item.price.discountPercentage);

    CartItem cartItem = CartItem(
        id: null,
        name: item.name,
        description: item.description,
        itemCode: item.itemCode,
        itemId: item.id,
        available: item.available,
        imageName: item.imageName,
        quantity: quantity,
        price: price,
        userName: "rakesh");
    var result = await cartItemServices.addToCart(cartItem);
    isLoading = false;
    update();
    return result;
  }

  createOrderCOD(String userName, String addressId) async {
    orderService.createCODOrder(userName, addressId);
    update();
  }

  removeFromCart(String id) async {
    cartItemServices.removeFromCart(id);
    int index = cartItems.indexWhere((element) => element.id == id);
    cartItems.removeAt(index);
    update();
  }

  selectAddress(String selectedAddressId) async{
    selectedAddressId = selectedAddressId;
    update();
  }
}
