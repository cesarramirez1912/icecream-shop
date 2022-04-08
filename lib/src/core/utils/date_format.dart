import 'package:intl/intl.dart';

class DateFormatBr {
  static String formatBrFromDateTime(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
