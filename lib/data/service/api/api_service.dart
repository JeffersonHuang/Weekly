import 'package:weekly/data/models/api_response.dart';

abstract class ApiService {
  void init();

  Future<ApiResponse> get({required String path, Map<String, dynamic>? query});
}
