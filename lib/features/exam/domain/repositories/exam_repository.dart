import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/save_answer_request.dart';
import '../entities/end_exam_entity.dart';
import '../entities/exam_entity.dart';
import '../entities/exam_ready_entity.dart';

abstract class ExamRepository {
  Future<Either<Failure, BaseResponseEntity<ExamReadyEntity>>> getExamReady(
      String id);

  Future<Either<Failure, BaseResponseEntity<ExamEntity>>>
      getExamQuestionOrPercentage(String id);

  Future<Either<Failure, BaseResponseEntity<bool>>> saveAnswer(
      SaveAnswerRequest request);

  Future<Either<Failure, BaseResponseEntity<EndExamEntity>>> endExam(
      String studentExamId);
}
