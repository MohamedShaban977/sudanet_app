import 'package:dartz/dartz.dart';
import 'package:sudanet_app/features/courses/domain/entities/courses_entity.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';

abstract class CourseByCategoryRepo {
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesByCategory(String categoryId);
}
