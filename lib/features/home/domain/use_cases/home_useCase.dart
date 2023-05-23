import 'package:dartz/dartz.dart';
import 'package:sudanet_app/features/home/domain/entities/courses_entity.dart';
import 'package:sudanet_app/features/home/domain/repositories/home_repository.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../entities/categories_entity.dart';

class CategoriesUseCases
    implements UseCase<CollectionResponseEntity<CategoriesEntity>, NoParams> {
  final HomeRepository repository;

  CategoriesUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>> call(
          NoParams params) =>
      repository.getCategoriesRepo();
}

class CourseUseCases
    implements UseCase<CollectionResponseEntity<CoursesEntity>, NoParams> {
  final HomeRepository repository;

  CourseUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>> call(
          NoParams params) =>
      repository.getCoursesRepo();
}

class SliderUseCases implements UseCase<CollectionResponseEntity, NoParams> {
  final HomeRepository repository;

  SliderUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity>> call(NoParams params) =>
      repository.getSliders();
}
