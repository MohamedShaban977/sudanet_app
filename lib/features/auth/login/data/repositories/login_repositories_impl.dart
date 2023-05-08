import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/contents_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/cache/cache_data_shpref.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repositories.dart';
import '../data_sources/login_data_source.dart';
import '../models/login_request.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginEntity>> loginUser(LoginRequest request) async {
    try {
      final res = await dataSource.loginDataSource(request);
      res.refresh.isNotEmpty
          ? await sl<CacheHelper>().saveData(
              key: Constants.cachedDataLogin,
              value: json.encode(res.access),
            )
          : null;
      return res.refresh.isNotEmpty
          ? Right(res)
          : left(const ServerFailure(AppStrings.errorOccurred));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
