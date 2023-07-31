import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/exam_ready_response.dart';
import '../models/exam_response.dart';
import '../models/save_answer_request.dart';

abstract class ExamDataSource {
  Future<BaseResponse<ExamReadyResponse>> getExamReady(String id);

  Future<BaseResponse<ExamResponse>> getExamQuestionOrPercentage(String id);

  Future<BaseResponse<bool>> saveAnswer(SaveAnswerRequest request);

  Future<BaseResponse<dynamic>> endExam(String studentExamId);
}

class ExamDataSourceImpl implements ExamDataSource {
  final ApiConsumer consumer;

  ExamDataSourceImpl(this.consumer);

  @override
  Future<BaseResponse<ExamReadyResponse>> getExamReady(String id) async {
    final response = await consumer.get(
      EndPoint.getExamReady,
      queryParameters: {"Id": id},
    );

    final res = BaseResponse<ExamReadyResponse>.fromJson(
      response,
      (data) => ExamReadyResponse.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse<ExamResponse>> getExamQuestionOrPercentage(
      String id) async {
    final response = await consumer.get(
      EndPoint.getExam,
      queryParameters: {"Id": id},
    );

    final res = BaseResponse<ExamResponse>.fromJson(
      response,
      (data) => ExamResponse.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse<bool>> saveAnswer(SaveAnswerRequest request) async {
    final response = await consumer.post(
      EndPoint.getExam,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse<bool>.fromJson(response);

    return res;
  }

  @override
  Future<BaseResponse> endExam(String studentExamId) async {
    final response = await consumer.post(EndPoint.endExam,
        data: {"StudentExamId": studentExamId}, isFormData: true);

    final res = BaseResponse<ExamReadyResponse>.fromJson(
      response,
      (data) => ExamReadyResponse.fromJson(data),
    );

    return res;
  }
}
