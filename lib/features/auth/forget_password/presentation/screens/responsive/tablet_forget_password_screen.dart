import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';

class TabletForgetPasswordScreen extends StatelessWidget {
  const TabletForgetPasswordScreen(
      {Key? key,

      required this.email, required this.onTap,
  })
      : super(key: key);

  final TextEditingController email;

  final Future<dynamic> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: Column(
        children: [
          const SizedBox(height: AppSize.s11),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: const [
              CustomButtonChangeLanguageWidget(),
              CustomButtonBackWidget()
            ],
          ),
          Expanded(
            child: Center(
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.s40),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Expanded(
                            child: Column(
                              children: [
                                /// image
                                Image.asset(ImageAssets.logoImg, alignment: Alignment.center),
                                const SizedBox(height: AppSize.s38),

                                ///
                                Text(AppStrings.forgetPassword.tr(), style: context.displayLarge),

                                const SizedBox(height: AppSize.s13),

                                ///
                                // Text(AppStrings.pleaseLoginToComplete.tr(),
                                //     style: context.titleLarge),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: Responsive.isTablet(context) ? 400 : 450,
                              child: Column(
                                children: [
                                  ///

                                  const SizedBox(height: AppSize.s50),
                                  const SizedBox(height: AppSize.s50),

                                  /// email
                                  CustomTextFormField(
                                    hint: AppStrings.email.tr(),
                                    prefixWidget: const SizedBox(),
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) => Validator.isValidEmail(email.text),
                                  ),

                                  const SizedBox(height: AppSize.s37),

                                  ///  button
                                  CustomButtonWithLoading(
                                    text: AppStrings.sendCode.tr(),
                                    onTap: onTap,
                                  ),

                                  const SizedBox(height: AppSize.s37),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
