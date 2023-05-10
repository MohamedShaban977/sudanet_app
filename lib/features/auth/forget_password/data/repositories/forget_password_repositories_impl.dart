import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/repositories/forget_password_repositories.dart';
import '../data_sources/forget_password_data_source.dart';
import '../models/forget_password_request.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordDataSource dataSource;

  ForgetPasswordRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ForgetPasswordEntity>> forgetPassword(ForgetPasswordRequest request) async {
    try {
      final res = await dataSource.forgetPasswordDataSource(request);

      return Right(res);

    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
