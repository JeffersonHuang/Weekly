import 'weekly_item.dart';

class WeeklyData {
  late String year;
  late String month;
  List<WeeklyItem> array;

  WeeklyData({required this.year, required this.month, required this.array});

  factory WeeklyData.fromJson(Map<String, dynamic> json) {
    return WeeklyData(
      year: json['year'],
      month: json['month'],
      array: (json['array'] as List)
          .map((item) => WeeklyItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'array': array.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'WeeklyData{year: $year, month: $month, array: $array}';
  }
}
