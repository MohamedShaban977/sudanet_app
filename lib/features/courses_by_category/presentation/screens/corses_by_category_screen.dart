import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/courses_by_category/presentation/cubit/courses_by_category_cubit.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../courses/presentation/screens/responsive_widget/card_tablet_widget.dart';

const double _desiredItemWidth = 260;

class CoursesByCategoryScreen extends StatelessWidget {
  const CoursesByCategoryScreen({Key? key, required this.categoryId})
      : super(key: key);
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.subjects.tr()),
      body: BlocBuilder<CoursesByCategoryCubit, CoursesByCategoryState>(
        builder: (context, state) {
          final cubit = sl<CoursesByCategoryCubit>().get(context);
          if (state is CoursesByCategoryLoadingState) {
            return const CustomLoadingScreen();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await sl<CoursesByCategoryCubit>()
                  .getCoursesByCategoryId(categoryId);
            },
            child: SizedBox(
              height: context.height - kToolbarHeight,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSize.s20),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Text(
                        '${AppStrings.viewAllFirstStageSubjects.tr()} ',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: ColorManager.primary,
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ResponsiveGridList(
                        desiredItemWidth: Responsive.isMobileS(context) ||
                                Responsive.isMobile(context)
                            ? context.width * 0.4
                            : _desiredItemWidth,
                        minSpacing: 2.0,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        rowMainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cubit.coursesByCategoryIdItems.isNotEmpty)
                            ...List.generate(
                              cubit.coursesByCategoryIdItems.length,
                              (index) => CardCoursesTabletWidget(
                                height: 150,
                                course: cubit.coursesByCategoryIdItems[index],
                              ),
                            )
                          else
                            Text(
                              'لا يوجد بيانات لعرضها',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: ColorManager.primary,
                                    fontSize: 20,
                                  ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
