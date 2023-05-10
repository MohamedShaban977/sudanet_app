import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../models/forget_password_request.dart';
import '../models/forget_password_response.dart';

abstract class ForgetPasswordDataSource {
  Future<ForgetPasswordResponse> forgetPasswordDataSource(ForgetPasswordRequest request);
}

class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  ApiConsumer apiConsumer;

  ForgetPasswordDataSourceImpl({required this.apiConsumer});

  @override
  Future<ForgetPasswordResponse> forgetPasswordDataSource(ForgetPasswordRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.register,
      data: request.toJson(),
    );
    final res = ForgetPasswordResponse.fromJson(response);
    return res;
  }
}
