import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../../data/models/forget_password_request.dart';
import '../entities/forget_password_entity.dart';
import '../repositories/forget_password_repositories.dart';

class ForgetPasswordUseCases implements UseCase<ForgetPasswordEntity, ForgetPasswordRequest> {
  final ForgetPasswordRepository repository;

  ForgetPasswordUseCases({required this.repository});

  @override
  Future<Either<Failure, ForgetPasswordEntity>> call(ForgetPasswordRequest request) =>
      repository.forgetPassword(request);
}
