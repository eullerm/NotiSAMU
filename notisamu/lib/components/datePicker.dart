import 'package:flutter/material.dart';

Future<DateTime> selectDate(
    BuildContext context, int range, DateTime selectedDate) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: new DateTime.now().subtract(Duration(days: range)),
    lastDate: new DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.red,
          ),
          accentColor: Colors.red,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
        ),
        child: child,
      );
    },
  );
  if (picked != null &&
      picked != selectedDate &&
      picked.compareTo(DateTime.now()) <= 0)
    return picked;
  else
    return DateTime.now();
}
