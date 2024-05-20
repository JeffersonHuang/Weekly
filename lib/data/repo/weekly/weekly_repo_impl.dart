import 'dart:io';

import 'package:weekly/constants/api_path.dart';
import 'package:weekly/data/models/api_response.dart';
import 'package:weekly/data/service/service.dart';

import 'weekly_repo.dart';

class WeeklyRepoImpl implements WeeklyRepo {
  @override
  Future<ApiResponse> getAllCategories() async {
    final response = await apiService.get(path: ApiPath.catalogue);
    return response;
  }

  @override
  Future<String> getWeekly({required String url}) async {
    final File file = await storageService.getLocalFile(url);
    if (await file.exists()) {
      return await file.readAsString();
    }
    final response = await apiService.get(path: ApiPath.prefix + url);
    if (response.statusCode == 200) {
      storageService.cacheWeeklyData(cacheFileName: url, data: response.data);
      return response.data;
    }
    return response.message;
  }

  @override
  Future<String> getLocalFile() async {
    final file = await storageService.getLocalFile(ApiPath.readme);
    if (await file.exists()) {
      return file.readAsString();
    }
    return "";
  }
}
