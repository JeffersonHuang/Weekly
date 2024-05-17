import 'package:weekly/data/service/storage/storage_service.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageServiceImpl extends StorageService {
  @override
  Future<File> getLocalFile(String cacheFileName) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$cacheFileName';
    return File(path);
  }

  @override
  Future<void> cacheWeeklyData({
    required String cacheFileName,
    required String data,
  }) async {
    final File file = await getLocalFile(cacheFileName);
    await file.writeAsString(data);
  }
}
