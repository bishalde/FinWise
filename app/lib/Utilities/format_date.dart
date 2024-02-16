import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  // Format the date according to your requirement
  final indianDateFormat = DateFormat('dd/MM/yyyy');
  final indianDate = indianDateFormat.format(dateTime.toLocal());

  return indianDate;
}
