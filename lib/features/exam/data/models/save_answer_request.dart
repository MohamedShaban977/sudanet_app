class SaveAnswerRequest {
  final int? answer;
  final int? examQuestionId;

  SaveAnswerRequest({
    this.answer,
    this.examQuestionId,
  });

  Map<String, dynamic> toJson() => {
        "Answer": answer,
        "ExamQuestionId": examQuestionId,
      };
}
