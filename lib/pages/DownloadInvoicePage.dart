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
        final date = DateTime.now();
        final dueDate = date.add(Duration(days: 7));
/*
        final invoice = Invoice(
          supplier: Supplier(
            name: 'Sarah Field',
            address: 'Sarah Street 9, Beijing, China',
            paymentInfo: 'https://paypal.me/sarahfieldzz',
          ),
          customer: Customer(
            name: 'Apple Inc.',
            address: 'Apple Street, Cupertino, CA 95014',
          ),
          info: InvoiceInfo(
            date: date,
            dueDate: dueDate,
            description: 'My description...',
            number: '${DateTime
                .now()
                .year}-9999',
          ),
          items: [
            InvoiceLineItem(
              description: 'Coffee',
              date: DateTime.now(),
              quantity: 3,
              vat: 0.19,
              unitPrice: 5.99,
            ),
            InvoiceItem(
              description: 'Water',
              date: DateTime.now(),
              quantity: 8,
              vat: 0.19,
              unitPrice: 0.99,
            ),
            InvoiceItem(
              description: 'Orange',
              date: DateTime.now(),
              quantity: 3,
              vat: 0.19,
              unitPrice: 2.99,
            ),
            InvoiceItem(
              description: 'Apple',
              date: DateTime.now(),
              quantity: 8,
              vat: 0.19,
              unitPrice: 3.99,
            ),
            InvoiceItem(
              description: 'Mango',
              date: DateTime.now(),
              quantity: 1,
              vat: 0.19,
              unitPrice: 1.59,
            ),
            InvoiceItem(
              description: 'Blue Berries',
              date: DateTime.now(),
              quantity: 5,
              vat: 0.19,
              unitPrice: 0.99,
            ),
            InvoiceItem(
              description: 'Lemon',
              date: DateTime.now(),
              quantity: 4,
              vat: 0.19,
              unitPrice: 1.29,
            ),
          ],
        );
     */
        final Invoice invoice = await controller.getInvoice(this.orderId);
        print(invoice);
        final pdfFile = await PdfInvoiceApi.generate(invoice);

        PdfApi.openFile(pdfFile);
      },
    );
  }
}
