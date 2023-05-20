import 'package:dartz/dartz.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/features/auth/login/domain/entities/login_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../../data/models/signup_request.dart';
import '../repositories/signup_repositories.dart';

class SignUpUseCases
    implements UseCase<BaseResponseEntity<UserEntity>, SignUpRequest> {
  final SignUpRepository repository;

  SignUpUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> call(
          SignUpRequest request) =>
      repository.signUpUser(request);
}
