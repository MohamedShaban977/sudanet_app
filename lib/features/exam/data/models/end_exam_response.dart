import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/features/exam/domain/entities/end_exam_entity.dart';

// {
// "examName": "أمتحان الحصة الثانية",
// "isFail": true,
// "percentage": "0%"
// }
class EndExamResponse extends EndExamEntity {
  EndExamResponse({
    final String? examName,
    final bool? isFail,
    final String? percentage,
  }) : super(
          examName: examName.orEmpty(),
          percentage: percentage.orEmpty(),
          isFail: isFail.orEmptyB(),
        );

  factory EndExamResponse.fromJson(Map<String, dynamic> json) =>
      EndExamResponse(
        examName: json["examName"],
        isFail: json["isFail"],
        percentage: json["percentage"],
      );
}
