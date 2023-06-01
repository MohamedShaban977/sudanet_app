import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/course_details_entity.dart';

abstract class CourseDetailsRepository {
  Future<Either<Failure, BaseResponseEntity<CourseDetailsEntity>>>
      getPublicCourseDetails(String id);
}
