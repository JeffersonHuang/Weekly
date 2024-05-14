abstract class WeeklyRepo {
  Future<String> getWeekly({required String url});

  Future<String> getAllCategories();
}
