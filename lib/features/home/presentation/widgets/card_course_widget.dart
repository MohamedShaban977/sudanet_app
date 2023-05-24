import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../widgets/view_image_widget.dart';
import '../../domain/entities/courses_entity.dart';

class CardCourseWidget extends StatelessWidget {
  final CoursesEntity course;

  const CardCourseWidget({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(AppPadding.p12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: ImageWidget(imagePath: course.imagePath),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: AppSize.s5),
                        Text(
                          course.name,
                          style: context.displayMedium
                              .copyWith(color: ColorManager.primary),
                        ),
                        const SizedBox(height: AppSize.s5),
                        Text(
                          course.teacherName,
                          style: context.bodySmall
                              .copyWith(color: ColorManager.textGray),
                        ),
                        const SizedBox(height: AppSize.s5),
                        ElevatedButton(
                            onPressed: () {
                              ///TODO:
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                              minimumSize: const Size.fromHeight(40.0),
                              backgroundColor: ColorManager.secondary,
                            ),
                            child: Text(
                              '${course.price} ${course.currencyName}',
                              textAlign: TextAlign.center,
                              style: context.displayMedium.copyWith(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
