import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../main_layout_home/presentation/cubit/nav_bar_cubit.dart';
import '../cubit/home_cubit.dart';
import 'card_course_widget.dart';

class CoursesWidget extends StatelessWidget {
  const CoursesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = sl<HomeCubit>().get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0, end: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'أقوى الدورات في المرحلة الاولى',
                style:
                    context.displayLarge.copyWith(color: ColorManager.textGray),
              ),
              TextButton(
                onPressed: () => NavBarCubit.get(context).changeIndex(2),
                style: TextButton.styleFrom(
                    foregroundColor: ColorManager.secondary,
                    side: const BorderSide(
                        color: ColorManager.secondary, width: 2)),
                child: Text(
                  'المزيد',
                  style:
                      context.titleMedium.copyWith(color: ColorManager.primary),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: List.generate(
                cubit.coursesItems.length,
                (index) => CardCourseWidget(
                      course: cubit.coursesItems[index],
                    )),
          ),
        ),
      ],
    );
  }
}
