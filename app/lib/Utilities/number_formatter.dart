import 'package:intl/intl.dart';

extension IndianNumberFormatting on String {
  String formatNumber() {
    int number = int.tryParse(this) ?? 0;
    return NumberFormat('#,##,##0', 'en_IN').format(number);
  }
}