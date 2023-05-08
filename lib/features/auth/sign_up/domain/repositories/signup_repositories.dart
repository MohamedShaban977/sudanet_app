import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/signup_request.dart';
import '../entities/signup_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpEntity>> signUpUser(SignUpRequest request);
}
