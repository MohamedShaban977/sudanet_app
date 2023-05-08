
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
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';
import '../../cubit/signup_cubit.dart';
import '../../widgets/login_button_row_text_widget.dart';

class MobileSignUpScreen extends StatelessWidget {
  const MobileSignUpScreen(
      {Key? key,
      required this.userName,
      required this.password,
      required this.onTap,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.passwordConfirmation})
      : super(key: key);

  final TextEditingController userName;
  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController passwordConfirmation;
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
              Text(AppStrings.welcomeInformationRegister.tr(),
                  style: context.titleLarge),

              const SizedBox(height: AppSize.s48),

              /// user Name
              CustomTextFormField(
                label: AppStrings.userName.tr(),
                controller: userName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidUserName(userName.text),
              ),

              const SizedBox(height: AppSize.s16),

              /// email
              CustomTextFormField(
                label: AppStrings.email.tr(),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidEmail(email.text),
              ),

              const SizedBox(height: AppSize.s16),

              /// first name
              CustomTextFormField(
                label: AppStrings.firstName.tr(),
                controller: firstName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidUserName(firstName.text),
              ),

              const SizedBox(height: AppSize.s16),

              /// last name
              CustomTextFormField(
                label: AppStrings.lastName.tr(),
                controller: lastName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidUserName(lastName.text),
              ),

              const SizedBox(height: AppSize.s16),

              /// password
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  final cubit = sl<SignUpCubit>().get(context);
                  return CustomTextFormField(
                    label: AppStrings.password.tr(),
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: cubit.isPassword,
                    iconData: cubit.suffix,
                    onTapIcon: () => cubit.changePassVisibility(),
                    validator: (value) =>
                        Validator.isValidPassword(password.text),
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              /// conform password
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  final cubit = sl<SignUpCubit>().get(context);
                  return CustomTextFormField(
                    label: AppStrings.passwordConfirmation.tr(),
                    controller: passwordConfirmation,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: cubit.isPassword,
                    iconData: cubit.suffix,
                    onTapIcon: () => cubit.changePassVisibility(),
                    validator: (value) => Validator.isValidConfirmPassword(
                        password.text, passwordConfirmation.text),
                  );
                },
              ),
              const SizedBox(height: AppSize.s30),

              /// signUp button
              CustomButtonWithLoading(
                height: AppSize.s40,
                text: AppStrings.signUp.tr(),
                onTap: onTap,
              ),

              const SizedBox(height: AppSize.s37),

              ///
              const LoginButtonRowTextWidget(),

              const SizedBox(height: AppSize.s16),
            ],
          ),
        ),
      ),
    );
  }
}
