import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/routes/magic_router.dart';
import 'package:sudanet_app/core/routes/routes_name.dart';
import 'package:sudanet_app/features/courses/domain/entities/courses_entity.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../widgets/view_info_data_courses_widget.dart';

class CardCoursesTabletWidget extends StatelessWidget {
  final CoursesEntity course;
  final double? height;
  final double? width;

  const CardCoursesTabletWidget({
    super.key,
    required this.course,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MagicRouterName.navigateTo(RoutesNames.courseDetails),
      child: Card(
        // margin: const EdgeInsets.all(AppPadding.p8),
        elevation: AppSize.s8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ImageWidget(
                width: context.width,
                height: height,
                imagePath: course.imagePath),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ViewInfoDataCoursesWidget(course: course),
            ),
          ],
        ),
      ),
    );
/*
    return Card(
      // margin: const EdgeInsets.all(AppPadding.p8),
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s11)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ImageWidget(
                width: width,
                imagePath:
                    'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
              ),
            ),
            Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(0.0), //AppPadding.p12),
                  child: ViewInfoDataSubjectsWidget(index: index),
                )),
          ],
        ),
      ),
    );
*/
  }
}
