import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/categories/presentation/screens/responsive_widget/card_mobile_widget.dart';
import 'package:sudanet_app/features/categories/presentation/screens/responsive_widget/card_tablet_widget.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';

const double _heightItem = 160;
const double _desiredItemWidth = 250;

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

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
            ResponsiveGridList(
              rowMainAxisAlignment: MainAxisAlignment.start,
              desiredItemWidth:
                  Responsive.isMobileS(context) || Responsive.isMobile(context)
                      ? context.width
                      : _desiredItemWidth,
              minSpacing: AppSize.s1,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                10,
                (index) => Responsive(
                  mobile: CardCategoriesMobileWidget(
                    index: index,
                    height: _heightItem,
                  ),
                  tablet: CardCategoriesTabletWidget(
                    index: index,
                    width: context.width,
                  ),
                  desktop: CardCategoriesTabletWidget(
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
