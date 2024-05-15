import 'package:dio/dio.dart';
import 'package:weekly/data/models/api_response.dart';

import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  late Dio _dio;

  @override
  void init() {
    _dio = Dio();
    // _dio.interceptors.add(
    //   TalkerDioLogger(
    //     settings: const TalkerDioLoggerSettings(
    //       printRequestHeaders: true,
    //       printResponseHeaders: true,
    //       printResponseMessage: true,
    //     ),
    //   ),
    // );
  }

  @override
  Future<ApiResponse> get(
      {required String path, Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, queryParameters: query);

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
