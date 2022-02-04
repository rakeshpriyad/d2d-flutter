import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/pages/CartPage.dart';
import 'package:d2d_flutter/pages/ItemDetailPage.dart';
import 'package:d2d_flutter/services/itemService.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:d2d_flutter/widgets/BottomNavigationBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  Function? superSetState;
  int selectedPosition = 0;

  HomePage(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  @override
  _HomePageState createState() =>
      _HomePageState(superSetState, selectedPosition);
}

class _HomePageState extends State<HomePage> {
  Function? superSetState;
  int selectedPosition = 0;

  _HomePageState(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  ItemServices itemServices = ItemServices();
  List<Item> items = [];
  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkResponse(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CartPage(superSetState, selectedPosition)));
                  },
                  child: Stack(
                    children: [
                      GetBuilder<HomePageController>(
                          builder: (_) => Align(
                                child: Text(controller.cartItems.length > 0
                                    ? controller.cartItems.length.toString()
                                    : ''),
                                alignment: Alignment.topLeft,
                              )),
                      Align(
                        child: Icon(Icons.shopping_cart),
                        alignment: Alignment.center,
                      ),
                    ],
                  )),
            )
          ],
        ),
        body: Container(
          child: GetBuilder<HomePageController>(
            init: controller,
            builder: (_) => controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ShopItemListing(
                    superSetState: superSetState,
                    selectedPosition: selectedPosition,
                    items: controller.items,
                  ),
          ),
        )
        // body: getScaffold(controller,superSetState, selectedPosition),
        );
  }

  Widget getScaffold(controller, Function? changeTab, int selectedPosition) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBarWidget(
          changeTab, selectedPosition), //buildBottomNavigationBar(),
      body: Container(
        child: GetBuilder<HomePageController>(
          init: controller,
          builder: (_) => controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ShopItemListing(
                  superSetState: superSetState,
                  selectedPosition: selectedPosition,
                  items: controller.items,
                ),
        ),
      ),
    );
  }
}

class ShopItemListing extends StatelessWidget {
  final List<Item> items;

  ShopItemListing({
    this.superSetState,
    required this.selectedPosition,
    required this.items,
  });

  Function? superSetState;
  int selectedPosition = 0;

  HomePage(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          return ItemView(
            superSetState: this.superSetState,
            selectedPosition: this.selectedPosition,
            item: items[index],
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final Item item;
  static final String BASE_URL = ApiConst.IMG_BASE_URL;

  // ItemView({required this.item});

  Function? superSetState;
  int selectedPosition = 0;

  ItemView({
    this.superSetState,
    required this.selectedPosition,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: InkResponse(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemDetailPage(
                        superSetState: superSetState,
                        selectedPosition: selectedPosition,
                        itemId: item.id)));
          },
          child: Material(
            child: Container(
                height: 380.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Image.network(
                                  BASE_URL + item.imageName,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              child: true //item.fav
                                  ? Icon(
                                      Icons.favorite,
                                      size: 20.0,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 20.0,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${item.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "${item.price.unitPrice}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
