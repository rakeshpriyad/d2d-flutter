import 'package:d2d_flutter/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';

class AboutPage1 extends StatefulWidget {
  @override
  _AboutPageState1 createState() => _AboutPageState1();
}

class _AboutPageState1 extends State<AboutPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "About Us",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Text(
            "Shiv Jyoti is the retaile and wholesale Merchant of clothes.",
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(fontSize: 16, color: Colors.grey.shade800),
          ),
        ),
      ),
    );
  }
}
