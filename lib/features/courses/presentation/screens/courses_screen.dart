import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import 'responsive_widget/card_tablet_widget.dart';

const double _heightItem = 180;
const double _desiredItemWidth = 260;

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.subjects.tr()),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s20),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Text(
                AppStrings.viewAllFirstStageSubjects.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorManager.primary,
                    ),
              ),
            ),

            ///
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
                children: List.generate(
                  10,
                  (index) => CardSubjectsTabletWidget(index: index),

                  /*Responsive(
                    mobile: CardSubjectsTabletWidget(
                      index: index,
                      width: context.width,
                    ),
                    tablet: CardSubjectsTabletWidget(
                      index: index,
                      width: context.width,
                    ),
                    desktop: CardSubjectsTabletWidget(
                      index: index,
                      width: context.width,
                    ),
                  ),*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
