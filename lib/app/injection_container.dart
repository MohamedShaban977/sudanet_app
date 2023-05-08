import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_consumer.dart';
import '../core/api/app_interceptor.dart';
import '../core/api/dio_consumer.dart';
import '../core/cache/cache_data_shpref.dart';
import '../core/service/locale_service/data/local/data_sources/locale_data_sources.dart';
import '../core/service/locale_service/data/repositories/locale_repository_impl.dart';
import '../core/service/locale_service/domain/repositories/locale_repository.dart';
import '../core/service/locale_service/domain/use_cases/locale_useCase.dart';
import '../core/service/locale_service/manager/locale_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static final sl = GetIt.instance;

  static Future<void> initApp() async {
    ///! Features

    //Localization data Source
    sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(cacheHelper: sl()));

    //Localization Repository
    sl.registerLazySingleton<LocaleRepository>(() => LocaleRepositoryImpl(dataSource: sl()));
    //Localization UseCase
    sl.registerLazySingleton<GetSavedLangUseCase>(() => GetSavedLangUseCase(repository: sl()));
    sl.registerLazySingleton<ChangeLangUseCase>(() => ChangeLangUseCase(repository: sl()));

    ///Bloc==> cubit
    /// Bloc
    // LocaleCubit
    sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit(savedLangUseCase: sl(), changeLangUseCase: sl()));
    //Connection Cubit
    // sl.registerLazySingleton<ConnectionCubit>(() => ConnectionCubit(connectivity: sl(), checker: sl()));

    ///! core
    ///_initDataCore();
    ///! core
    // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
    sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sharedPreferences: sl<SharedPreferences>()));

    ///! External
    /// _initDataExternal();
    /// External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => Dio());
    // sl.registerLazySingleton(() => InternetConnectionChecker());
    // sl.registerLazySingleton(() => Connectivity());
    sl.registerLazySingleton(() => AppInterceptors());
    sl.registerLazySingleton(() => LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: false,
          responseHeader: true,
          responseBody: false,
          error: true,
        ));
  }

  static initLoginGetIt() {
    //Login Data Source
    // if (!sl.isRegistered<LoginDataSource>()) {
    //   sl.registerFactory<LoginDataSource>(
    //       () => LoginDataSourceImpl(apiConsumer: sl<ApiConsumer>()));
    // }
    // //Login Repository
    // if (!sl.isRegistered<LoginRepository>()) {
    //   sl.registerFactory<LoginRepository>(
    //       () => LoginRepositoryImpl(dataSource: sl<LoginDataSource>()));
    // }
    // //Login Use Cases
    // if (!sl.isRegistered<LoginUseCases>()) {
    //   sl.registerFactory<LoginUseCases>(
    //       () => LoginUseCases(repository: sl<LoginRepository>()));
    // }
    // // Login Cubit
    // if (!GetIt.I.isRegistered<LoginCubit>()) {
    //   sl.registerFactory<LoginCubit>(
    //       () => LoginCubit(loginUseCases: sl<LoginUseCases>()));
    // }
  }


}
