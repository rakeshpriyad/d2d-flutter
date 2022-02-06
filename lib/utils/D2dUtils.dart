import 'package:intl/intl.dart';

class D2DUtils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';

  static formatDate(DateTime date) => {
        if (date != null) {DateFormat.yMd().format(date)}
      };
}
