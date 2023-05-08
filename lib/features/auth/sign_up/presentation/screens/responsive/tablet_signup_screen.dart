
import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';
import '../../widgets/login_button_row_text_widget.dart';

class TabletLoginScreen extends StatelessWidget {
  const TabletLoginScreen(
      {Key? key,
      required this.userName,
      required this.password,
      required this.onTap})
      : super(key: key);

  final TextEditingController userName;

  final TextEditingController password;

  final Future<dynamic> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: CustomButtonChangeLanguageWidget(),
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  /// image
                  Image.asset(ImageAssets.logoImg,
                      alignment: Alignment.center),
                  const SizedBox(height: AppSize.s38),

                  ///
                  Text(AppStrings.signIn.tr(), style: context.displayLarge),

                  const SizedBox(height: AppSize.s13),

                  ///
                  Text(AppStrings.pleaseLoginToComplete.tr(),
                      style: context.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Responsive.isTablet(context) ? 400 : 450,
                    child: Column(
                      children: [
                        ///
                        CustomTextFormField(
                            label: AppStrings.userName.tr(),
                            controller: userName),

                        const SizedBox(height: AppSize.s16),

                        ///
                        CustomTextFormField(
                            label: AppStrings.userName.tr(),
                            controller: password),

                        const SizedBox(height: AppSize.s30),

                        /// login button
                        CustomButtonWithLoading(
                          height: AppSize.s40,
                          text: AppStrings.login.tr(),
                          onTap: onTap,
                        ),

                        const SizedBox(height: AppSize.s37),

                        ///
                        const LoginButtonRowTextWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
