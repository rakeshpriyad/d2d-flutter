import 'package:d2d_flutter/api/pdf_api.dart';
import 'package:d2d_flutter/api/pdf_invoice_api.dart';
import 'package:d2d_flutter/controller/D2DController.dart';
import 'package:d2d_flutter/models/Invoice.dart';
import 'package:d2d_flutter/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadInvoicePage extends StatelessWidget {
  String orderId;


  DownloadInvoicePage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return getInvoiceWidget(controller);
  }


  Widget getInvoiceWidget(HomePageController controller) {
    return ButtonWidget(
      text: 'Download Invoice',
      onClicked: () async {
        final Invoice invoice = await controller.getInvoice(this.orderId);
       // print(invoice);
        final pdfFile = await PdfInvoiceApi.generate(invoice);
        PdfApi.openFile(pdfFile);
      },
    );
  }
}
