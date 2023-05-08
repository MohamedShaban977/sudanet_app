
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import '../../domain/entities/login_entity.dart';

class LoginResponse extends LoginEntity {
  LoginResponse({
    String? refresh,
    String? access,
  }) : super(access: access.orEmpty(), refresh: refresh.orEmpty());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        refresh: json["refresh"],
        access: json["access"],
      );
}
