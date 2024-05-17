import 'package:get_it/get_it.dart';

import 'api/api_service.dart';
import 'api/api_service_impl.dart';
import 'storage/storage_service.dart';
import 'storage/storage_service_impl.dart';

final getIt = GetIt.instance;

void initService() {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}

void initStorageService() {
  getIt.registerLazySingleton<StorageService>(() => StorageServiceImpl());
}

ApiService get apiService => getIt.get<ApiService>();

StorageService get storageService => getIt.get<StorageService>();
