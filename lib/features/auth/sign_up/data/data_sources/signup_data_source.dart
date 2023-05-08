import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';

abstract class SignUpDataSource {
  Future<SignUpResponse> signUpDataSource(SignUpRequest request);
}

class SignUpDataSourceImpl implements SignUpDataSource {
  ApiConsumer apiConsumer;

  SignUpDataSourceImpl({required this.apiConsumer});

  @override
  Future<SignUpResponse> signUpDataSource(SignUpRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.register,
      data: request.toJson(),
    );
    final res = SignUpResponse.fromJson(response);
    return res;
  }
}
