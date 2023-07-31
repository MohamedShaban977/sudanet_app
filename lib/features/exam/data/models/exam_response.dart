import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../domain/entities/exam_entity.dart';

class ExamResponse extends ExamEntity {
  ExamResponse({
    final int? studentExamId,
    final String? examTime,
    final int? remainingExamTimeBySeconds,
    final String? examName,
    final int? questionsCount,
    final List<ExamQuestion>? examQuestions,
    final String? percentage,
  }) : super(
          studentExamId: studentExamId.orZero(),
          examTime: examTime.orEmpty(),
          remainingExamTimeBySeconds: remainingExamTimeBySeconds.orZero(),
          questionsCount: questionsCount.orZero(),
          examName: examName.orEmpty(),
          percentage: percentage.orEmpty(),
          examQuestions: examQuestions.orEmptyList(),
        );

  factory ExamResponse.fromJson(Map<String, dynamic> json) => ExamResponse(
        studentExamId: json["studentExamId"],
        examTime: json["examTime"],
        remainingExamTimeBySeconds: json["remainingExamTimeBySeconds"],
        examName: json["examName"],
        questionsCount: json["questionsCount"],
        examQuestions: json["examQuestions"] == null
            ? []
            : List<ExamQuestion>.from(
                json["examQuestions"]!.map((x) => ExamQuestion.fromJson(x))),
        percentage: json["percentage"],
      );
}

class ExamQuestion extends ExamQuestionsEntity {
  ExamQuestion({
    final int? examQuestionId,
    final String? examQuestionImage,
    final int? examQuestionAnswer,
    final bool? binHere,
  }) : super(
          examQuestionId: examQuestionId.orZero(),
          examQuestionAnswer: examQuestionAnswer.orZero(),
          examQuestionImage: examQuestionImage.orEmpty(),
          binHere: binHere.orEmptyB(),
        );

  factory ExamQuestion.fromJson(Map<String, dynamic> json) => ExamQuestion(
        examQuestionId: json["examQuestionId"],
        examQuestionImage: json["examQuestionImage"],
        examQuestionAnswer: json["examQuestionAnswer"],
        binHere: json["binHere"],
      );
}
