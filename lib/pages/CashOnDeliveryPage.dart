import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/Order.dart';
import 'package:d2d_flutter/pages/OrderPage.dart';
import 'package:d2d_flutter/pages/OrderPlacePage.dart';
import 'package:d2d_flutter/utils/CustomTextStyle.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashOnDeliveryPage extends StatefulWidget {
  String? selectedAddressId;
  Function? superSetState;
  int selectedPosition = 0;

  CashOnDeliveryPage({
    this.superSetState,
    required this.selectedPosition,
    this.selectedAddressId,
  });

  @override
  _CashOnDeliveryPageState createState() => _CashOnDeliveryPageState(
        superSetState: superSetState,
        selectedPosition: selectedPosition,
        selectedAddressId: selectedAddressId,
      );
}

class _CashOnDeliveryPageState extends State<CashOnDeliveryPage> {
  static final String BASE_URL = ApiConst.IMG_BASE_URL;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String? selectedAddressId;
  Function? superSetState;
  int selectedPosition = 0;


  _CashOnDeliveryPageState({
    this.superSetState,
    required this.selectedPosition,
    this.selectedAddressId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Back",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      //  onlinePayment(),
                      //  codPayment(),
                    ],
                  ),
                ),
                flex: 90,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () async {
                      Order order = await controller.createOrderCOD(
                          "rakesh", this.selectedAddressId!);
                      Navigator.of(context).push(new MaterialPageRoute(
                          //builder: (context) => OrderItemPage(order.orderItems)));
                          builder: (context) => OrderPage(
                              superSetState: superSetState,
                              selectedPosition: selectedPosition,
                              order: order)));
                    },
                    child: Text(
                      "Confirm Cash On Delivery",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              ),
            ],
          );
        }),
      ),
    );
  }

  onlinePayment() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border:
              Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => OrderPlacePage()));
            },
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Paytm/Netbanking/Card Payment",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
