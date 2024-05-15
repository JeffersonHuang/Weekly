import 'dart:developer';

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
    final response = await apiService.get(path: ApiPath.prefix + url);
    log(response.data);
    return response.data;
  }
}
