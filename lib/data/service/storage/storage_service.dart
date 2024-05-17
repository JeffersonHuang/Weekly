import 'dart:io';

abstract class StorageService {
  Future<File> getLocalFile(String cacheFileName);

  Future<void> cacheWeeklyData({
    required String cacheFileName,
    required String data,
  });
}
