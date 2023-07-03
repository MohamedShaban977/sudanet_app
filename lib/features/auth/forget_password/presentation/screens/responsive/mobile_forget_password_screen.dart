import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../login/presentation/screens/responsive/mobile_login_screen.dart';
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';

class MobileForgetPasswordScreen extends StatelessWidget {
  const MobileForgetPasswordScreen({
    Key? key,
    required this.onTap,
    required this.email,
  }) : super(key: key);

  final TextEditingController email;
  final Future<dynamic> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSize.s40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HelperButtonWidget(),
                  CustomButtonBackWidget()
                ],
              ),

              /// image
              Image.asset(ImageAssets.logoImg, alignment: Alignment.center),
              const SizedBox(height: AppSize.s38),

              ///
              Text(AppStrings.forgetPassword.tr(), style: context.displayLarge),

              const SizedBox(height: AppSize.s13),

              const SizedBox(height: AppSize.s40),

              /// email
              CustomTextFormField(
                hint: AppStrings.email.tr(),
                prefixWidget: const SizedBox(),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidEmail(email.text),
              ),

              const SizedBox(height: AppSize.s30),

              /// signUp button
              CustomButtonWithLoading(
                text: AppStrings.sendCode.tr(),
                onTap: onTap,
              ),

              const SizedBox(height: AppSize.s16),
            ],
          ),
        ),
      ),
    );
  }
}
