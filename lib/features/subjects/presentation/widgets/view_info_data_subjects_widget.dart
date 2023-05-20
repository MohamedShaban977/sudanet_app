import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';

class ViewInfoDataSubjectsWidget extends StatelessWidget {
  const ViewInfoDataSubjectsWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s5),
        Text(
          'المرحلة ${index + 1}',
          style: context.displayLarge.copyWith(color: ColorManager.primary),
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          '6 مواد',
          style: context.titleMedium.copyWith(color: ColorManager.textGray),
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          'المدرس الاول',
          style: context.bodyMedium.copyWith(color: ColorManager.textGray),
        ),
        const SizedBox(height: AppSize.s5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '6 \$',
                style:
                    context.displayLarge.copyWith(color: ColorManager.primary),
                overflow: TextOverflow.fade,
              ),
            ),
            Flexible(
              flex: 4,
              child: ElevatedButton(
                  onPressed: () {
                    ///TODO:
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondary,
                    padding: const EdgeInsets.all(12.0),
                    minimumSize: const Size.fromHeight(40.0),
                  ),
                  child: Text(
                    AppStrings.purchase.tr(),
                    style: context.titleLarge.copyWith(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.fade,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
