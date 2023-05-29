import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudanet_app/features/courses/data/data_sources/courses_data_sources.dart';
import 'package:sudanet_app/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:sudanet_app/features/home/data/data_sources/home_data_source.dart';
import 'package:sudanet_app/features/home/domain/repositories/home_repository.dart';
import 'package:sudanet_app/features/home/domain/use_cases/home_useCase.dart';

import '../core/api/api_consumer.dart';
import '../core/api/app_interceptor.dart';
import '../core/api/dio_consumer.dart';
import '../core/cache/cache_data_shpref.dart';
import '../core/service/locale_service/data/local/data_sources/locale_data_sources.dart';
import '../core/service/locale_service/data/repositories/locale_repository_impl.dart';
import '../core/service/locale_service/domain/repositories/locale_repository.dart';
import '../core/service/locale_service/domain/use_cases/locale_useCase.dart';
import '../core/service/locale_service/manager/locale_cubit.dart';
import '../features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import '../features/auth/forget_password/data/repositories/forget_password_repositories_impl.dart';
import '../features/auth/forget_password/domain/repositories/forget_password_repositories.dart';
import '../features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import '../features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import '../features/auth/login/data/data_sources/login_data_source.dart';
import '../features/auth/login/data/repositories/login_repositories_impl.dart';
import '../features/auth/login/domain/repositories/login_repositories.dart';
import '../features/auth/login/domain/use_cases/login_use_case.dart';
import '../features/auth/login/presentation/cubit/login_cubit.dart';
import '../features/auth/sign_up/data/data_sources/signup_data_source.dart';
import '../features/auth/sign_up/data/repositories/signup_repositories_impl.dart';
import '../features/auth/sign_up/domain/repositories/signup_repositories.dart';
import '../features/auth/sign_up/domain/use_cases/signup_use_case.dart';
import '../features/auth/sign_up/presentation/cubit/signup_cubit.dart';
import '../features/courses/data/repositories/course_repository_impl.dart';
import '../features/courses/domain/repositories/courses_repository.dart';
import '../features/courses/domain/use_cases/courses_use_case.dart';
import '../features/courses_by_category/data/data_sources/courses_by_category_data_source.dart';
import '../features/courses_by_category/data/repositories/courses_by_category_repo_impl.dart';
import '../features/courses_by_category/domain/repositories/courses_by_category_repo.dart';
import '../features/courses_by_category/domain/use_cases/courses_by_category_use_case.dart';
import '../features/courses_by_category/presentation/cubit/courses_by_category_cubit.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static final sl = GetIt.instance;

  static Future<void> initApp() async {
    ///! Features

    //Localization data Source
    sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(cacheHelper: sl()));

    //Localization Repository
    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(dataSource: sl()));
    //Localization UseCase
    sl.registerLazySingleton<GetSavedLangUseCase>(
        () => GetSavedLangUseCase(repository: sl()));
    sl.registerLazySingleton<ChangeLangUseCase>(
        () => ChangeLangUseCase(repository: sl()));

    ///Bloc==> cubit
    /// Bloc
    // LocaleCubit
    sl.registerLazySingleton<LocaleCubit>(
        () => LocaleCubit(savedLangUseCase: sl(), changeLangUseCase: sl()));
    //Connection Cubit

    // sl.registerLazySingleton<ConnectionCubit>(() => ConnectionCubit(connectivity: sl(), checker: sl()));
    // sl.registerLazySingleton<HomeCubit>(() => HomeCubit());

    ///! core
    ///_initDataCore();
    ///! core
    // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
    sl.registerLazySingleton<CacheHelper>(
        () => CacheHelper(sharedPreferences: sl<SharedPreferences>()));

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
    // Login Data Source
    if (!sl.isRegistered<LoginDataSource>()) {
      sl.registerFactory<LoginDataSource>(
          () => LoginDataSourceImpl(apiConsumer: sl<ApiConsumer>()));
    }
    //Login Repository
    if (!sl.isRegistered<LoginRepository>()) {
      sl.registerFactory<LoginRepository>(
          () => LoginRepositoryImpl(dataSource: sl<LoginDataSource>()));
    }
    // //Login Use Cases
    if (!sl.isRegistered<LoginUseCases>()) {
      sl.registerFactory<LoginUseCases>(
          () => LoginUseCases(repository: sl<LoginRepository>()));
    }
    // // Login Cubit
    if (!GetIt.I.isRegistered<LoginCubit>()) {
      sl.registerFactory<LoginCubit>(
          () => LoginCubit(loginUseCases: sl<LoginUseCases>()));
    }
  }

  static initSignupGetIt() {
    // Login Data Source
    if (!sl.isRegistered<SignUpDataSource>()) {
      sl.registerFactory<SignUpDataSource>(
          () => SignUpDataSourceImpl(apiConsumer: sl<ApiConsumer>()));
    }
    //Login Repository
    if (!sl.isRegistered<SignUpRepository>()) {
      sl.registerFactory<SignUpRepository>(
          () => SignUpRepositoryImpl(dataSource: sl<SignUpDataSource>()));
    }
    // //Login Use Cases
    if (!sl.isRegistered<SignUpUseCases>()) {
      sl.registerFactory<SignUpUseCases>(
          () => SignUpUseCases(repository: sl<SignUpRepository>()));
    }
    // // Login Cubit
    if (!GetIt.I.isRegistered<SignUpCubit>()) {
      sl.registerFactory<SignUpCubit>(
          () => SignUpCubit(signupUseCases: sl<SignUpUseCases>()));
    }
  }

  static initForgetPasswordGetIt() {
    // Login Data Source
    if (!sl.isRegistered<ForgetPasswordDataSource>()) {
      sl.registerFactory<ForgetPasswordDataSource>(
          () => ForgetPasswordDataSourceImpl(apiConsumer: sl<ApiConsumer>()));
    }
    //Login Repository
    if (!sl.isRegistered<ForgetPasswordRepository>()) {
      sl.registerFactory<ForgetPasswordRepository>(() =>
          ForgetPasswordRepositoryImpl(
              dataSource: sl<ForgetPasswordDataSource>()));
    }
    // //Login Use Cases
    if (!sl.isRegistered<ForgetPasswordUseCases>()) {
      sl.registerFactory<ForgetPasswordUseCases>(() =>
          ForgetPasswordUseCases(repository: sl<ForgetPasswordRepository>()));
    }
    // // Login Cubit
    if (!GetIt.I.isRegistered<ForgetPasswordCubit>()) {
      sl.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(
          forgetPasswordUseCases: sl<ForgetPasswordUseCases>()));
    }
  }

  static initHomeGetIt() {
    // Home Data Source
    if (!sl.isRegistered<HomeDataSource>()) {
      sl.registerLazySingleton<HomeDataSource>(
          () => HomeDataSourceImpl(apiConsumer: sl<ApiConsumer>()));
    }
    //Home Repository
    if (!sl.isRegistered<HomeRepository>()) {
      sl.registerLazySingleton<HomeRepository>(
          () => HomeRepositoryImpl(dataSource: sl<HomeDataSource>()));
    }
    // //Home Use Cases
    if (!sl.isRegistered<HomeCategoriesUseCases>()) {
      sl.registerLazySingleton<HomeCategoriesUseCases>(
          () => HomeCategoriesUseCases(repository: sl<HomeRepository>()));
    }
    if (!sl.isRegistered<HomeCourseUseCases>()) {
      sl.registerLazySingleton<HomeCourseUseCases>(
          () => HomeCourseUseCases(repository: sl<HomeRepository>()));
    }
    if (!sl.isRegistered<SliderUseCases>()) {
      sl.registerLazySingleton<SliderUseCases>(
          () => SliderUseCases(repository: sl<HomeRepository>()));
    }

    // // Home Cubit
    if (!sl.isRegistered<HomeCubit>()) {
      sl.registerLazySingleton<HomeCubit>(() => HomeCubit(
            categoriesUseCases: sl<HomeCategoriesUseCases>(),
            coursesUseCases: sl<HomeCourseUseCases>(),
            sliderUseCases: sl<SliderUseCases>(),
          ));
    } else {
      sl.resetLazySingleton<HomeCubit>();
    }
  }

  static initCoursesGetIt() {
    // Course By Category Data Source
    if (!sl.isRegistered<CoursesDataSource>()) {
      sl.registerLazySingleton<CoursesDataSource>(
          () => CoursesDataSourceImpl(consumer: sl<ApiConsumer>()));
    }
    //Course By Category Repository
    if (!sl.isRegistered<CourseRepository>()) {
      sl.registerLazySingleton<CourseRepository>(
          () => CourseRepositoryImpl(dataSource: sl<CoursesDataSource>()));
    }
    // //Home Use Cases
    if (!sl.isRegistered<CoursesUseCases>()) {
      sl.registerLazySingleton<CoursesUseCases>(
          () => CoursesUseCases(repository: sl<CourseRepository>()));
    }

    // // Home Cubit
    if (!sl.isRegistered<CoursesCubit>()) {
      sl.registerLazySingleton<CoursesCubit>(() => CoursesCubit(
            coursesUseCases: sl<CoursesUseCases>(),
          ));
    } else {
      sl.resetLazySingleton<CoursesCubit>();
    }
  }

  static initCoursesByCategoryGetIt() {
    // Course By Category Data Source
    if (!sl.isRegistered<CoursesByCategoryDataSource>()) {
      sl.registerLazySingleton<CoursesByCategoryDataSource>(
          () => CoursesByCategoryDataSourceImpl(consumer: sl<ApiConsumer>()));
    }
    //Course By Category Repository
    if (!sl.isRegistered<CourseByCategoryRepo>()) {
      sl.registerLazySingleton<CourseByCategoryRepo>(() =>
          CoursesByCategoryRepoImpl(
              dataSource: sl<CoursesByCategoryDataSource>()));
    }
    // //Home Use Cases
    if (!sl.isRegistered<CoursesByCategoryUseCases>()) {
      sl.registerLazySingleton<CoursesByCategoryUseCases>(() =>
          CoursesByCategoryUseCases(repository: sl<CourseByCategoryRepo>()));
    }

    // // Home Cubit
    if (!sl.isRegistered<CoursesByCategoryCubit>()) {
      sl.registerLazySingleton<CoursesByCategoryCubit>(
          () => CoursesByCategoryCubit(
                coursesByCategoryUseCases: sl<CoursesByCategoryUseCases>(),
              ));
    } else {
      sl.resetLazySingleton<CoursesByCategoryCubit>();
    }
  }
}
