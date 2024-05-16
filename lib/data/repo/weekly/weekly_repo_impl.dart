import 'dart:io';

import 'package:path_provider/path_provider.dart';
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
      final File file = await _getLocalFile(url);
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        final response = await _getWeeklyFromNetwork(url: url);
        _cacheWeeklyData(cacheFileName: url, data: response);
        return response;
      }
    } catch (e) {
      return "Oops，发生异常";
    }
  }

  Future<String> _getWeeklyFromNetwork({required String url}) async {
    final response = await apiService.get(path: ApiPath.prefix + url);
    return response.data;
  }

  Future<File> _getLocalFile(String cacheFileName) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$cacheFileName';
    return File(path);
  }

  Future<void> _cacheWeeklyData({
    required String cacheFileName,
    required String data,
  }) async {
    final File file = await _getLocalFile(cacheFileName);
    await file.writeAsString(data);
  }
}