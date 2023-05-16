import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import 'responsive_widget/card_mobile_widget.dart';
import 'responsive_widget/card_tablet_widget.dart';

const double heightItem = 140;
const double desiredItemWidth = 240;

class EducationalLevelsScreen extends StatelessWidget {
  const EducationalLevelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s20),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Text(
                AppStrings.viewAllEducationalLevels.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorManager.primary,
                    ),
              ),
            ),

            ///

            ///
            /*   GridView.count(
              crossAxisCount:
                  Responsive.isMobile(context) || Responsive.isMobileS(context)
                      ? 1
                      : Responsive.isTablet(context)
                          ? 3
                          : 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              childAspectRatio: Responsive.isMobile(context)
                  ? 2.6
                  : Responsive.isMobileS(context)
                      ? 2.0
                      : Responsive.isTablet(context)
                          ? 0.8
                          : 0.7,

              // Responsive.isMobile(context) ? 2.6 : 1.3,
              // padding: const EdgeInsets.all(4.0),
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                10,
                (index) => LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  return Responsive(
                    mobile: CardEducationalLevelsRowWidget(
                      index: index,
                      height: constraints.maxHeight,
                    ),
                    tablet: CardEducationalLevelsColumnWidget(
                      index: index,
                      width: constraints.maxWidth,
                    ),
                    desktop: CardEducationalLevelsColumnWidget(
                      index: index,
                      width: constraints.maxWidth,
                    ),
                  );
                }),
              ),
            ),*/

            ///
            ResponsiveGridList(
              rowMainAxisAlignment: MainAxisAlignment.start,
              desiredItemWidth:
                  Responsive.isMobileS(context) || Responsive.isMobile(context)
                      ? context.width
                      : desiredItemWidth,
              minSpacing: AppSize.s1,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                10,
                (index) => Responsive(
                  mobile: CardEducationalLevelsMobileWidget(
                    index: index,
                    height: heightItem,
                  ),
                  tablet: CardEducationalLevelsTabletWidget(
                    index: index,
                    width: context.width,
                  ),
                  desktop: CardEducationalLevelsTabletWidget(
                    index: index,
                    width: context.width,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: AppSize.s5,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(AppStrings.educationalLevels.tr(),
          style: context.displayLarge.copyWith(
              color: ColorManager.textGray, fontWeight: FontWeight.w700)),
    );
  }
}
