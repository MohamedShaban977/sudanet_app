import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/end_exam_entity.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/exam_ready_entity.dart';
import '../../domain/repositories/exam_repository.dart';
import '../data_sources/exam_data_source.dart';
import '../models/save_answer_request.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamDataSource dataSource;

  ExamRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, BaseResponseEntity<ExamReadyEntity>>> getExamReady(
      String id) async {
    try {
      final res = await dataSource.getExamReady(id);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<ExamEntity>>>
      getExamQuestionOrPercentage(String id) async {
    try {
      final res = await dataSource.getExamQuestionOrPercentage(id);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> saveAnswer(
      SaveAnswerRequest request) async {
    try {
      final res = await dataSource.saveAnswer(request);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<EndExamEntity>>> endExam(
      String studentExamId) async {
    try {
      final res = await dataSource.endExam(studentExamId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
