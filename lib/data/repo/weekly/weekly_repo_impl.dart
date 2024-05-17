import 'dart:io';

import 'package:weekly/constants/api_path.dart';
import 'package:weekly/data/service/service.dart';

import 'weekly_repo.dart';

class WeeklyRepoImpl implements WeeklyRepo {
  @override
  Future<String> getAllCategories() async {
    final response = await apiService.get(path: ApiPath.catalogue);
    return response.data;
  }

  @override
  Future<String> getWeekly({required String url}) async {
    try {
      final File file = await storageService.getLocalFile(url);
      if (await file.exists()) {
        return await file.readAsString();
      }

      final response = await _getWeeklyFromNetwork(url: url);
      storageService.cacheWeeklyData(cacheFileName: url, data: response);
      return response;
    } catch (e) {
      return "Oops，发生异常";
    }
  }

  Future<String> _getWeeklyFromNetwork({required String url}) async {
    final response = await apiService.get(path: ApiPath.prefix + url);
    return response.data;
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
