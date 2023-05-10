
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../domain/entities/forget_password_entity.dart';

class ForgetPasswordResponse extends ForgetPasswordEntity {
  ForgetPasswordResponse({

    final String? code,
  }) : super(code: code.orEmpty());

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(

    code: json["message"],
      );
}


