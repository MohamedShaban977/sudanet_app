import 'package:dartz/dartz.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/features/auth/login/presentation/manger/user_secure_storage.dart';

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
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> loginUser(
      LoginRequest request) async {
    // try {
    //   final res = await dataSource.loginDataSource(request);
    //   res.refresh.isNotEmpty
    //       ? await sl<CacheHelper>().saveData(
    //           key: Constants.cachedDataLogin,
    //           value: json.encode(res.access),
    //         )
    //       : null;
    //   return res.refresh.isNotEmpty
    //       ? Right(res)
    //       : left(const ServerFailure(AppStrings.errorOccurred));
    // } on ServerException catch (error) {
    //   return left(ServerFailure(error.message));
    // }

    try {
      var res = await dataSource.loginDataSource(request);
      var token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ik1vYW1lbiBNb3N0YWZhIiwibmFtZWlkIjoiMyIsImNlcnRzZXJpYWxudW1iZXIiOiJiYmNjMzcxMC1jMTFjLTQxNmItYjYyMi02NmNlMGZmZWVjNDIiLCJwcmltYXJ5Z3JvdXBzaWQiOiJTdHVkZW50IiwibmJmIjoxNjg4OTU4MjQyLCJleHAiOjE3NjgwMTc4NDIsImlhdCI6MTY4ODk1ODI0Mn0.4iGGciZg7covbxYNJ1t-gvJz5QZ_F3fbXzT1F7HaImM';

      res.success
          ? await UserSecureStorage.setUser(data: res.data!..token = token)
          : null;

      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
