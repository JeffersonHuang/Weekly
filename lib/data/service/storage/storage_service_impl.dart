import 'package:weekly/data/service/storage/storage_service.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageServiceImpl extends StorageService {
  @override
  Future<File> getLocalFile(String cacheFileName) async {
    final name = cacheFileName.replaceAll('docs/', '');
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$name';
    return File(path);
  }

  @override
  Future<void> cacheWeeklyData({
    required String cacheFileName,
    required String data,
  }) async {
    final name = cacheFileName.replaceAll('docs/', '');
    final File file = await getLocalFile(name);
    await file.writeAsString(data);
  }
}
//PathNotFoundException: Cannot open file, path = '/data/user/0/io.github.weekly.weekly/cache/docs/issue-290.md' (OS Error: No such file or directory, errno = 2)