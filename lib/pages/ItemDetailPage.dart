import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/CartItem.dart';
import 'package:d2d_flutter/models/Item.dart';
import 'package:d2d_flutter/pages/CartPage.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:d2d_flutter/widgets/CustomButton.dart';
import 'package:d2d_flutter/widgets/DotWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailPage extends StatefulWidget {
  final String itemId;

  Function? superSetState;
  int selectedPosition =0;
  ItemDetailPage({this.superSetState, required this.selectedPosition, required this.itemId});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState(superSetState: superSetState, selectedPosition: this.selectedPosition);
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late PageController pageController;
  int active = 0;
  String BASE_URL = ApiConst.IMG_BASE_URL;
  Function? superSetState;
  int selectedPosition =0;
  _ItemDetailPageState({this.superSetState, required this.selectedPosition});


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  Widget buildDot(int index, int num) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: (num == index) ? Colors.black38 : Colors.grey[200],
            shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find<HomePageController>();
    Item model = controller.getItem(widget.itemId);
    return Scaffold(
     /* appBar: AppBar(
        elevation: 0,
      ),*/
      appBar: AppBar(
        title: Text(""),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkResponse(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage(superSetState, selectedPosition)));
                },
                child: Stack(
                  children: [
                    GetBuilder<HomePageController>(builder: (_) => Align(
                      child: Text(controller.cartItems.length > 0 ? getQuantity(controller.cartItems) : ''),
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
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 280.0,
                  padding: EdgeInsets.only(top: 10.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            print(index);
                            setState(() {
                              active = index;
                            });
                          },
                          children: <Widget>[
                            Image.network(
                              BASE_URL + model.imageName,
                              height: 150.0,
                            ),
                            Image.network(
                              BASE_URL + model.imageName,
                              height: 150.0,
                            ),
                            Image.network(
                              BASE_URL + model.imageName,
                              height: 150.0,
                            ),
                            Image.network(
                              BASE_URL + model.imageName,
                              height: 150.0,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DotWidget(
                            activeIndex: active,
                            dotIndex: 0,
                          ),
                          DotWidget(
                            activeIndex: active,
                            dotIndex: 1,
                          ),
                          DotWidget(
                            activeIndex: active,
                            dotIndex: 2,
                          ),
                          DotWidget(
                            activeIndex: active,
                            dotIndex: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GetBuilder<HomePageController>(builder: (value) {
                  return Container(
                      height: 270.0,
                      alignment: Alignment(1.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                //controller.setToFav(model.id, !model.fav);
                                var msg = "";
                                /*if (model.fav) {
                                  msg = "${model.name} marked as favourite";
                                } else {
                                  msg = "${model.name} removed from favourite";
                                }*/
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(msg)));
                              },
                              child: true // model.fav
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
                      ));
                })
              ],
            ),
            Divider(
              color: Colors.grey[300],
              height: 1.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.name,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 19.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text("Shiv Jyoti897987"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 18.0),
          height: 60.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      child: Text(
                        "Total Amount",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                    Text("${model.price.unitPrice}",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              GetBuilder<HomePageController>(builder: (_) {
                bool isAdded = controller.isAlreadyInCart(model.id);
                if (isAdded) {
                  return CustomButton(
                    name: "REMOVE CART",
                    onTap: () async {
                      try {
                        controller.removeFromCart(model.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Item removed from cart successfully")));
                      } catch (e) {
                        print(e);
                      }
                    },
                  );
                }
                return CustomButton(
                  name: "ADD TO CART",
                  onTap: controller.isLoading
                      ? null
                      : () async {
                          try {
                            controller.addToCart(model);
                            controller.getCartList();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Item added in cart successfully")));
                          } catch (e) {
                            print(e);
                          }
                        },
                );
              })
            ],
          )),
    );
  }

  getQuantity(List<CartItem> cartItems) {
    double sum = 0.0;
    cartItems.forEach((e) {
      sum += e.quantity.unitQuantity!;
    });
    return "₹$sum";
  }
}
