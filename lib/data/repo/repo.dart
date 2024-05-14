import 'package:get_it/get_it.dart';

import 'weekly/weekly_repo.dart';
import 'weekly/weekly_repo_impl.dart';

final getIt = GetIt.instance;

void initRepo() {
  getIt.registerLazySingleton<WeeklyRepo>(() => WeeklyRepoImpl());
}

WeeklyRepo get weeklyRepo => getIt.get<WeeklyRepo>();
