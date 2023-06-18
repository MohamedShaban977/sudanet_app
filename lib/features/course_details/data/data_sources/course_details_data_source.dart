import 'package:sudanet_app/features/auth/login/presentation/manger/user_secure_storage.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/buy_course_request.dart';
import '../models/course_details_response.dart';

abstract class CourseDetailsDataSource {
  Future<BaseResponse<CourseDetailsResponse>> getPublicCourseDetail(String id);

  Future<BaseResponse> buyCourse(BuyCourseRequest request);
}

class CourseDetailsDataSourceImpl implements CourseDetailsDataSource {
  final ApiConsumer apiConsumer;

  CourseDetailsDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<CourseDetailsResponse>> getPublicCourseDetail(
      String id) async {
    final response = await apiConsumer.get((UserSecureStorage.getToken() != null
        ? EndPoint.getAuthCourseDetail
        : EndPoint.getPublicCourseDetail)
        + id);
    final res = BaseResponse<CourseDetailsResponse>.fromJson(
      response,
          (data) => CourseDetailsResponse.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse> buyCourse(BuyCourseRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.buyCourse,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse.fromJson(response);
    return res;
  }
}
