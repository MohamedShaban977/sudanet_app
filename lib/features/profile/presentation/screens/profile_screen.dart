import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/auth/login/presentation/manger/user_secure_storage.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/service/locale_service/manager/locale_cubit.dart';
import '../../../../widgets/custom_image_network_view.dart';

const String url =
    'https://images.pexels.com/photos/2325446/pexels-photo-2325446.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        height: context.heightBodyWithNav,
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.02),
                  _buildCardViewInfo(context),
                  SizedBox(height: context.height * 0.02),
                  CustomButtonProfile(
                    iconData: Icons.language,
                    text: AppStrings.language.tr(),
                    onTap: () => sl<LocaleCubit>().changeLang(context),
                  ),
                  SizedBox(height: context.height * 0.02),
                  CustomButtonProfile(
                    iconData: Icons.logout,
                    text: 'Logout'.tr(),
                    onTap: () async {
                      await UserSecureStorage.removeUser().then((value) {
                        MagicRouterName.navigateAndPopAll(
                            RoutesNames.loginRoute);

                        print(UserSecureStorage.getMacId());
                      });
                    },
                  ),
                  SizedBox(height: context.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppStrings.profile.tr()),
    );
  }

  Widget _buildCardViewInfo(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: const EdgeInsets.all(AppPadding.p8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: ColorManager.background,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: CustomViewImageNetwork(
            image: url,
            height: 250.0,
            width: context.width,
          ),
        ),
      ],
    );
  }
}

class CustomButtonProfile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final void Function()? onTap;

  const CustomButtonProfile({
    Key? key,
    required this.iconData,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 5,
          color: ColorManager.background,
          child: InkWell(
            hoverColor: ColorManager.primary.withOpacity(0.5),
            splashColor: ColorManager.primary,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: context.width * 0.02),
                  Icon(
                    iconData, // Icons.lock_outline,
                    color: ColorManager.textGray,
                  ),
                  SizedBox(width: context.width * 0.05),
                  Text(text, //'Change Password',
                      style: context.displayMedium),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: ColorManager.secondary,
                  ),
                  SizedBox(width: context.width * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
