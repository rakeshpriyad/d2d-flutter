class ApiConst{
  static const String URL="http://10.0.2.2:8080";
  static const String authUrl="${URL}/api/auth/signin";
  static const String authKey='Your Token';
  static const String IMG_BASE_URL = "${URL}/d2d/image/";
  static final String BASE_URL = "${URL}/d2d";

  static final String SHIPPING_BASE_URL = "http://10.0.2.2:8080/d2d/customer/shipping/address";
  static final String COD_ORDER_BASE_URL = "${URL}/d2d/orders/cart/cod";
  static final String INVOICE_BASE_URL = "http://10.0.2.2:8080/d2d/invoices/order";
}