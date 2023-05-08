import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../../app/injection_container.dart';
import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../cubit/login_cubit.dart';
import '../../widgets/custom_button_lang_widget.dart';
import '../../widgets/register_button_row_text_widget.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen(
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
    return SizedBox(
      height: context.heightBody,
      width: context.width,
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: CustomButtonChangeLanguageWidget(),
              ),

              /// image
              Image.asset(ImageAssets.loginImg, alignment: Alignment.center),
              const SizedBox(height: AppSize.s38),

              ///
              Text(AppStrings.signIn.tr(), style: context.displayLarge),

              const SizedBox(height: AppSize.s13),

              ///
              Text(AppStrings.pleaseLoginToComplete.tr(),
                  style: context.titleLarge),

              const SizedBox(height: AppSize.s48),

              ///
              CustomTextFormField(
                label: AppStrings.userName.tr(),
                controller: userName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidUserName(userName.text),
              ),

              const SizedBox(height: AppSize.s16),

              ///
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  final cubit = sl<LoginCubit>().get(context);
                  return CustomTextFormField(
                    label: AppStrings.password.tr(),
                    controller: password,
                    obscureText: cubit.isPassword,
                    iconData: cubit.suffix,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    onTapIcon: () => cubit.changePassVisibility(),
                    validator: (value) =>
                        Validator.isValidPassword(password.text),
                  );
                },
              ),

              const SizedBox(height: AppSize.s30),

              /// login button
              CustomButtonWithLoading(
                height: AppSize.s40,
                text: AppStrings.login.tr(),
                onTap: onTap,
              ),

              const SizedBox(height: AppSize.s37),

              ///
              const RegisterButtonRowTextWidget(),

              /// image
            ],
          ),
        ),
      ),
    );
  }
}
