part of 'categories_bloc.dart';

class Categories {
  List<WeeklyData> categories;
  List<BookItem> books = [];

  bool isLoading;

  Categories(this.categories, this.isLoading) {
    var preYear = '';
    var index = 0;
    while (index < categories.length) {
      var cnt = 0;
      List<WeeklyData> list = [];
      preYear = categories[index].year;
      while (index < categories.length && preYear == categories[index].year) {
        cnt += categories[index].array.length;
        list.add(categories[index]);
        index++;
      }
      books.add(BookItem(year: preYear, count: cnt, categories: list));
    }

    // 创建一个按年份分组的映射
//     var yearGroups = categories.fold<Map<String, int>>({},
//         (Map<String, int> map, WeeklyData data) {
//       if (!map.containsKey(data.year)) {
//         map[data.year] = 0;
//       }
//       map[data.year] = map[data.year]! + data.array.length;
//       return map;
//     });
//
// // 将映射转换为BookItem列表
//     yearGroups.forEach((year, count) {
//       books.add(BookItem(year: year, count: count));
//     });
  }
}
