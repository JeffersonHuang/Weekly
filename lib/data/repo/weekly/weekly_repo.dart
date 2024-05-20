import 'package:weekly/data/models/api_response.dart';

abstract class WeeklyRepo {
  Future<String> getWeekly({required String url});

  Future<ApiResponse> getAllCategories();

  Future<String> getLocalFile();
}
