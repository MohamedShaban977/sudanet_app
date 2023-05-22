import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';

class ViewInfoDataEducationalWidget extends StatelessWidget {
  const ViewInfoDataEducationalWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Text(
          'المرحلة ${index + 1}',
          style: context.displayLarge.copyWith(color: ColorManager.primary),
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          '6 مواد',
          style: context.displaySmall.copyWith(color: ColorManager.textGray),
        ),
        const Spacer(),
        ElevatedButton(
            onPressed: () {
              ///TODO:
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12.0),
              minimumSize: const Size.fromHeight(40.0),
            ),
            child: Text(
              AppStrings.findAvailableSubjects.tr(),
              textAlign: TextAlign.center,
              style: context.displayMedium.copyWith(
                  color: ColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            )),
      ],
    );
  }
}