
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/users/data/data_source/local/app_database.dart';
import 'features/users/data/data_source/remote/chach_interceptor.dart';
import 'features/users/data/data_source/remote/dio_client.dart';
import 'features/users/data/repository/user_repository_impl.dart';
import 'features/users/domain/repository/user_repository.dart';
import 'features/users/domain/usecase/get_users_usecase.dart';
import 'features/users/presentation/provider/user_provider.dart';






final sl = GetIt.instance;

Future<void> init() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //base
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => CacheInterceptor(appDatabase: sl()));
  sl.registerLazySingleton(() => DioClient(dio: sl(), cacheInterceptor: sl() ));

  // Dependencies
  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(sl())
  );

  //UseCases
  sl.registerSingleton<GetUsersUseCase>(
      GetUsersUseCase(sl())
  );


  // Provider
  sl.registerFactory(() => UserProvider(
      getUsersUseCase: sl()
  ));

}
