import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../entities/course_details_entity.dart';
import '../repositories/course_details_repository.dart';

class CoursesUseCases
    implements UseCase<BaseResponseEntity<CourseDetailsEntity>, String> {
  final CourseDetailsRepository repository;

  CoursesUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<CourseDetailsEntity>>> call(
          String id) =>
      repository.getPublicCourseDetails(id);
}
