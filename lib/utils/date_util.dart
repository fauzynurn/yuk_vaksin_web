import 'package:intl/intl.dart';

final dayMonthYearDateFormatter = DateFormat('dd MMMM yyyy', 'id');
final standardDateTimeFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
final yearMonthYearDateFormatter = DateFormat('yyyy-MM-dd');
final hourMinuteDateFormatter = DateFormat('HH:mm');

extension DateTimeStringFormatter on String {
  DateTime get toCompleteDate => standardDateTimeFormatter.parse(this);

  String get toDayMonthYearFormat =>
      dayMonthYearDateFormatter.format(toCompleteDate);

  String get toCompleteDateTime =>
      '$toDayMonthYearFormat ${hourMinuteDateFormatter.format(toCompleteDate)}';
}

extension DateTimeFormatter on DateTime {
  String get toDayMonthYearFormat => dayMonthYearDateFormatter.format(this);

  String get toYearMonthDayFormat => yearMonthYearDateFormatter.format(this);
}
