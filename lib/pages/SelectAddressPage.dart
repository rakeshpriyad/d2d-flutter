import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/ShippingAddress.dart';
import 'package:d2d_flutter/pages/CheckOutPage.dart';
import 'package:d2d_flutter/pages/PaymentOptionPage.dart';
import 'package:d2d_flutter/utils/CustomTextStyle.dart';
import 'package:d2d_flutter/utils/api-const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAddressPage extends StatefulWidget {


  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  static final String BASE_URL = ApiConst.IMG_BASE_URL;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

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
              icon: Icon(Icons.arrow_back,color: Colors.black,),
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
                  child:
                  ListView(
                    shrinkWrap: true,
                    children: controller.addressList
                        .map((address) => generateShippingAddress(context, address))
                        .toList(),
                  ),
                ),
                flex: 90,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () {
                      controller.selectAddress(controller.addressList[0].id);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => PaymentOptionPage(controller.addressList[0].id)));
                    },
                    child: Text(
                      "Deliver to this Address",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget generateShippingAddress(BuildContext context, ShippingAddress address) {
    return selectedAddressSection(address);
  }

  selectedAddressSection(ShippingAddress address) {

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${address.address1}",
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style:
                          CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.indigoAccent.shade200, fontSize: 8),
                    ),
                  )
                ],
              ),
              createAddressText("${address.address2}", 16),
              createAddressText(" ${address.address3}", 6),
              createAddressText("${address.stateId}", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: "${address.mobileNo}",
                      style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Edit / Change",
              style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 12, color: Colors.indigo.shade700),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 12, color: Colors.indigo.shade700)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
