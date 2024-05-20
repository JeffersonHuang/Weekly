import 'weekly_data.dart';

class BookItem {
  final String year;
  final int count;

  List<WeeklyData> categories;

  BookItem({required this.year, required this.count, required this.categories});
}
