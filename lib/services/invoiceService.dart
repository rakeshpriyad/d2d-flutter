import 'package:d2d_flutter/models/Invoice.dart';
import 'package:d2d_flutter/services/apiService.dart';
import 'package:d2d_flutter/services/storageService.dart';

class InvoiceService {
  ApiService apiService = ApiService();
  StorageService storageService = StorageService();

  Future<Invoice> getInvoice(String orderId) async {
    return await apiService.loadInvoice(orderId);
  }

  loadInvoice(String orderId) async {
    return getInvoice(orderId);
  }
}
