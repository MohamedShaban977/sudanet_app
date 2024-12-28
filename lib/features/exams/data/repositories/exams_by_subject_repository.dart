import 'package:dartz/dartz.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/core/error/exceptions.dart';
import 'package:sudanet_app/core/error/failures.dart';
import 'package:sudanet_app/features/exams/data/models/exams_by_subject_item_model.dart';

import '../data_sources/exams_by_subject_data_source.dart';

abstract class ExamsBySubjectRepository {
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsBySubject(String subjectId);
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsNotification();
}

class ExamsBySubjectRepositoryImpl extends ExamsBySubjectRepository {
  final ExamsBySubjectDataSource dataSource;

  ExamsBySubjectRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsBySubject(String subjectId) async {
    try {
      final res = await dataSource.getExamsBySubject(subjectId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsNotification() async {
    try {
      final res = await dataSource.getExamsNotifications();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
