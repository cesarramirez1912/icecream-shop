import 'package:intl/intl.dart';

class MoneyFormat {
  static String Gs(dynamic _total) {
    return NumberFormat.currency(locale: 'eu', decimalDigits: 0)
        .format(_total)
        .replaceAll('EUR', '');
  }
}
