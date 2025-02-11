import 'package:intl/intl.dart';

extension CustomeDateFormat on DateTime {
  String formatDatetime({String? format}) {
    return DateFormat(format ?? 'dd/MM/yyyy').format(this);
  }
}
