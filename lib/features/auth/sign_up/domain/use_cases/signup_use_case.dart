import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../../data/models/signup_request.dart';
import '../entities/signup_entity.dart';
import '../repositories/signup_repositories.dart';

class SignUpUseCases implements UseCase<SignUpEntity, SignUpRequest> {
  final SignUpRepository repository;

  SignUpUseCases({required this.repository});

  @override
  Future<Either<Failure, SignUpEntity>> call(SignUpRequest request) =>
      repository.signUpUser(request);
}
