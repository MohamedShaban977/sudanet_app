import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/service/locale_service/manager/locale_cubit.dart';

class CustomButtonChangeLanguageWidget extends StatelessWidget {
  const CustomButtonChangeLanguageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSize.s0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s11),
          side: const BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5,
          )),
      color: ColorManager.secondary.withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s11),
        onTap: () => sl<LocaleCubit>().get(context).changeLang(context),
        splashColor: ColorManager.secondary,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: SizedBox(
            width: AppSize.s25,
            height: AppSize.s25,
            child: Center(
              child: Text(
                AppStrings.lang.tr(),
                textAlign: TextAlign.center,
                style: context.displayLarge.copyWith(
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
