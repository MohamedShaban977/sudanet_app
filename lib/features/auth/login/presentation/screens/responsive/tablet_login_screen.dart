import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../../app/injection_container.dart';
import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/color_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../core/routes/magic_router.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../cubit/login_cubit.dart';
import '../../widgets/custom_button_lang_widget.dart';
import '../../widgets/register_button_row_text_widget.dart';

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
    return SizedBox(
      height: context.height,
      child: Column(
        children: [
          const SizedBox(height: AppSize.s11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomButtonChangeLanguageWidget(),
              GestureDetector(
                onTap: () =>
                    MagicRouterName.navigateTo(RoutesNames.mainLayoutApp),
                child: Text(
                  AppStrings.registerLater.tr(),
                  style: context.displayMedium.copyWith(
                      color: ColorManager.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: IntrinsicHeight(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const Spacer(),
                      const SizedBox(height: AppSize.s40),

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
                                Text(AppStrings.signIn.tr(),
                                    style: context.displayLarge),

                                const SizedBox(height: AppSize.s13),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      Responsive.isTablet(context) ? 400 : 450,
                                  child: Column(
                                    children: [
                                      ///
                                      CustomTextFormField(
                                        hint: AppStrings.userName.tr(),
                                        prefixIcon: Icons.person_2_rounded,
                                        controller: userName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) =>
                                            Validator.isValidUserName(
                                                userName.text),
                                      ),
                                      const SizedBox(height: AppSize.s16),

                                      ///
                                      BlocBuilder<LoginCubit, LoginState>(
                                        builder: (context, state) {
                                          final cubit =
                                              sl<LoginCubit>().get(context);
                                          return CustomTextFormField(
                                            hint: AppStrings.password.tr(),
                                            controller: password,
                                            obscureText: cubit.isPassword,
                                            iconData: cubit.suffix,
                                            prefixIcon: Icons.lock,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTapIcon: () =>
                                                cubit.changePassVisibility(),
                                            validator: (value) =>
                                                Validator.isValidPassword(
                                                    password.text),
                                          );
                                        },
                                      ),

                                      const SizedBox(height: AppSize.s30),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                MagicRouterName.navigateTo(
                                                    RoutesNames
                                                        .forgetPasswordRoute),
                                            child: Text(
                                                AppStrings.forgetPassword.tr(),
                                                style: context.displayMedium
                                                    .copyWith(
                                                        color: ColorManager
                                                            .textGray)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: AppSize.s30),

                                      /// login button
                                      CustomButtonWithLoading(
                                        text: AppStrings.login.tr(),
                                        onTap: onTap,
                                      ),

                                      const SizedBox(height: AppSize.s37),

                                      ///
                                      const RegisterButtonRowTextWidget(),
                                    ],
                                  ),
                                ),
                              ],
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
