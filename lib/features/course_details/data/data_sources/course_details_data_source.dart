import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/course_details_response.dart';

abstract class CourseDetailsDataSource {
  Future<BaseResponse<CourseDetailsResponse>> getPublicCourseDetail(String id);
}

class CourseDetailsDataSourceImpl implements CourseDetailsDataSource {
  final ApiConsumer apiConsumer;

  CourseDetailsDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<CourseDetailsResponse>> getPublicCourseDetail(
      String id) async {
    final response = await apiConsumer.get(EndPoint.getPublicCourseDetail + id);
    final res = BaseResponse<CourseDetailsResponse>.fromJson(
      response,
      (data) => CourseDetailsResponse.fromJson(data),
    );

    return res;
  }
}
