import 'package:dartz/dartz.dart';
import 'package:sudanet_app/core/api/service_response.dart';

import '../../../../core/error/failures.dart';
import '../entities/categories_entity.dart';
import '../entities/courses_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CollectionResponseEntity>> getSliders();

  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesRepo();

  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>>
      getCategoriesRepo();
}
