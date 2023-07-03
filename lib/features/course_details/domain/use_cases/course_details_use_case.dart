import 'package:dartz/dartz.dart';
import 'package:sudanet_app/features/course_details/domain/entities/course_lecture_details_entity.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../data/models/buy_course_request.dart';
import '../entities/course_details_entity.dart';
import '../repositories/course_details_repository.dart';

class GetCourseDetailsUseCases
    implements UseCase<BaseResponseEntity<CourseDetailsEntity>, String> {
  final CourseDetailsRepository repository;

  GetCourseDetailsUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<CourseDetailsEntity>>> call(
          String id) =>
      repository.getCourseDetails(id);
}

class BuyCourseUseCases
    implements UseCase<BaseResponseEntity, BuyCourseRequest> {
  final CourseDetailsRepository repository;

  BuyCourseUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(BuyCourseRequest request) =>
      repository.buyCourse(request);
}

class GetCourseLectureDetailsUseCases
    implements UseCase<BaseResponseEntity<CourseLectureDetailsEntity>, String> {
  final CourseDetailsRepository repository;

  GetCourseLectureDetailsUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<CourseLectureDetailsEntity>>> call(
          String id) =>
      repository.getCourseLecture(id);
}
