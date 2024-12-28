import 'package:sudanet_app/core/api/api_consumer.dart';
import 'package:sudanet_app/core/api/end_point.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/features/exams/data/models/exams_by_subject_item_model.dart';

abstract class ExamsBySubjectDataSource {
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsBySubject(String subjectId);

  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsNotifications();
}

class ExamsBySubjectDataSourceImpl implements ExamsBySubjectDataSource {
  final ApiConsumer consumer;

  ExamsBySubjectDataSourceImpl({required this.consumer});

  @override
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsBySubject(String subjectId) async {
    final response = await consumer.get(EndPoint.getStudentExamsBySubject, queryParameters: {
      "CourseId": subjectId,
    });

    final res = CollectionResponse<ExamsBySubjectItemModel>.fromJson(
      response,
      (list) => list.map((e) => ExamsBySubjectItemModel.fromJson(e)).toList(),
    );

    return res;
  }

  @override
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsNotifications() async {
    final response = await consumer.get(EndPoint.getStudentExamNotifications);

    final res = CollectionResponse<ExamsBySubjectItemModel>.fromJson(
      response,
      (list) => list.map((e) => ExamsBySubjectItemModel.fromJson(e)).toList(),
    );

    return res;
  }
}
