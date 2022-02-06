import 'package:d2d_flutter/models/InvoiceInfo.dart';
import 'package:d2d_flutter/models/InvoiceLineItem.dart';
import 'package:d2d_flutter/models/customer.dart';
import 'package:d2d_flutter/models/supplier.dart';

class Invoice {
  final String id;
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceLineItem> items;

  const Invoice({
    required this.id,
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));
    List<InvoiceLineItem> items = [];
    var invoiceItemsJson =json["lineItems"] as List<dynamic>;

    if(invoiceItemsJson != null) {
      for (var i = 0; i < invoiceItemsJson.length; i++) {
        Map<String, dynamic> map = invoiceItemsJson[i];
        items.add(InvoiceLineItem.fromJson(map));
      }
    }


    return Invoice(
      id: json['id'],
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      supplier: Supplier(
        name: 'Shiv Jyoti',
        address: 'Mangal Hat chauk',
        paymentInfo: 'COD',
      ),
      customer: Customer(
        name: 'Rakesh Kumar',
        address: 'Majrohi Raghunandan',
      ),
      items: items,
    );
  }
}
