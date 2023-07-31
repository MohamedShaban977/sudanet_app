/*
{
"studentExamId": 11,
        "examTime": "10 دقائق ",
        "remainingExamTimeBySeconds": 600,
"examName": "أمتحان الحصة الثانية",
"questionsCount": 2,
"examQuestions": [
{
"examQuestionId": 21,
"examQuestionImage": "https://suda-net.com/Upload/6742722202354653AMWhatsAppImage2023-06-06at11.39.11PM.jpeg",
"examQuestionAnswer": 0,
"binHere": true
}
],
"percentage": null
}*/

import 'package:equatable/equatable.dart';

class ExamEntity extends Equatable {
  final int studentExamId;

  final String examTime;
  final int remainingExamTimeBySeconds;

  final int questionsCount;

  final String examName;

  final String percentage;
  final List<ExamQuestionsEntity> examQuestions;

  const ExamEntity({
    required this.studentExamId,
    required this.examTime,
    required this.remainingExamTimeBySeconds,
    required this.questionsCount,
    required this.examName,
    required this.percentage,
    required this.examQuestions,
  });

  @override
  List<Object?> get props => [
        studentExamId,
        examTime,
        remainingExamTimeBySeconds,
        questionsCount,
        examName,
        percentage,
        examQuestions,
      ];
}

/*{
"examQuestionId": 21,
"examQuestionImage": "https://suda-net.com/Upload/6742722202354653AMWhatsAppImage2023-06-06at11.39.11PM.jpeg",
"examQuestionAnswer": 0,
"binHere": true
}*/
class ExamQuestionsEntity extends Equatable {
  final int examQuestionId;
  final int examQuestionAnswer;
  final String examQuestionImage;
  final bool binHere;

  const ExamQuestionsEntity(
      {required this.examQuestionId,
      required this.examQuestionAnswer,
      required this.examQuestionImage,
      required this.binHere});

  @override
  List<Object?> get props => [
        examQuestionId,
        examQuestionAnswer,
        examQuestionImage,
        binHere,
      ];
}
