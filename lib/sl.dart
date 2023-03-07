// if you are curious. SI is short for service locator :).

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_tracker/features/manage_transactions/data/datasources/local_data_source.dart';
import 'package:spending_tracker/features/manage_transactions/data/repos/transaction_repo_impl.dart';
import 'package:spending_tracker/features/manage_transactions/domain/repos/transaction_repo.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/providers/transaction_management_provider.dart';

final sl = GetIt.instance;

Future<void> configServices() async {
  // registeratino will be in the following manner.
  // 3d pary stuff. shared preferences for now.
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // local data source.
  sl.registerSingleton<LocalDataSource>(
      LocalDataSourceSharedPreferences(sharedPreferences: sl()));

  // repo.
  sl.registerLazySingleton<TransactionRepo>(
      () => TransactionRepoImpl(datasource: sl()));

  // state managers, most likely provider.
  sl.registerFactory<TransactionManagementProvider>(
      () => TransactionManagementProvider(repository: sl()));
}
