import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", ""); // حذف #
  if (hex.length == 6) {
    hex = "FF$hex"; // افزودن مقدار شفافیت (FF = 100%)
  }
  return Color(int.parse("0x$hex"));
}

TimeOfDay? timeFromString(String? time) {
  if (time == null || time.isEmpty) return null;
  final parts = time.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String? timeToString(TimeOfDay? time) {
  if (time == null) return null;
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

String formatNumber(num number) {
  final formatter = NumberFormat("#,###.##");
  return formatter.format(number);
}

String formatGregorianDate(DateTime date) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

String formatGregorianDayOfWeek(DateTime date) {
  final formatter = DateFormat('EEEE', 'en_US');
  return formatter.format(date);
}

String formatGregorian(String date) {
  final formatter = DateFormat('EEE d/M/y', 'en_US');
  return formatter.format(DateTime.parse(date));
  // return formatter.format(date);
}

int parsedNumber(textNumber) {
  if (textNumber.contains(',')) {
    // If the number contains a comma, we assume it's formatted with thousands separators
    textNumber = textNumber.replaceAll(',', '');
  }
  // String text = textNumber.replaceAll(',', '');
  return int.tryParse(textNumber) ?? 0;
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(',', '');
    String formattedText = _formatNumber(text);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatNumber(String input) {
    if (input.isEmpty) return input;
    StringBuffer buffer = StringBuffer();
    int offset = input.length % 3;
    if (offset > 0) {
      buffer.write(input.substring(0, offset));
    }
    for (int i = offset; i < input.length; i += 3) {
      if (buffer.isNotEmpty) {
        buffer.write(',');
      }
      buffer.write(input.substring(i, i + 3));
    }
    return buffer.toString();
  }
}

int calculateDaysDifference(String inputDate) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime pastDate = dateFormat.parse(inputDate);

  DateTime currentDate = DateTime.now();

  int differenceInDays = currentDate.difference(pastDate).inDays;

  return differenceInDays;
}

// int calculateDaysDifference(DateTime pastDate) {
//   DateTime currentDate = DateTime.now();
//   int differenceInDays = currentDate.difference(pastDate).inDays;

//   return differenceInDays;
// }

// String formatJalaliDate(DateTime date) {
//   final Jalali jDate = Jalali.fromDateTime(date);
//   return '${jDate.year}-${jDate.month}-${jDate.day}';
// }

// String formatJalaliDayOfWeek(DateTime date) {
//   final Jalali jDate = Jalali.fromDateTime(date);
//   final f = jDate.formatter;
//   return f.wN;
// }
