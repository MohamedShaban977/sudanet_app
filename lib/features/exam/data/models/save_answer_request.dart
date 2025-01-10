class SaveAnswerRequest {
  final String? answer;
  final int? examQuestionId;

  SaveAnswerRequest({
    required this.answer,
    required this.examQuestionId,
  });

  Map<String, dynamic> toJson() => {
        "Answer": answer,
        "ExamQuestionId": examQuestionId,
      };
}
