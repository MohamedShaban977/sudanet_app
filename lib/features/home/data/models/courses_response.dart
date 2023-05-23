import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../domain/entities/courses_entity.dart';

class CoursesResponse extends CoursesEntity {
  CoursesResponse({
    final int? id,
    final String? name,
    final String? imagePath,
    final String? teacherName,
    final String? price,
    final String? currencyName,
  }) : super(
          id: id.orZero(),
          name: name.orEmpty(),
          imagePath: imagePath.orEmpty(),
          teacherName: teacherName.orEmpty(),
          price: price.orEmpty(),
          currencyName: currencyName.orEmpty(),
        );

  factory CoursesResponse.fromJson(Map<String, dynamic> json) =>
      CoursesResponse(
        id: json["id"],
        name: json["name"],
        imagePath: json["imgPath"],
        teacherName: json["teacherName"],
        price: json["price"],
        currencyName: json["currencyName"],
      );
}
