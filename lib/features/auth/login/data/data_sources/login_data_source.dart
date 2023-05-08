import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class LoginDataSource {
  Future<LoginResponse> loginDataSource(LoginRequest request);
}

class LoginDataSourceImpl implements LoginDataSource {
  ApiConsumer apiConsumer;

  LoginDataSourceImpl({required this.apiConsumer});

  @override
  Future<LoginResponse> loginDataSource(LoginRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.login,
      data: request.toJson(),
    );
    final res = LoginResponse.fromJson(response);
    return res;
  }
}
