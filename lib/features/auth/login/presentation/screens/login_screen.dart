import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/theme_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../cubit/login_cubit.dart';
import 'responsive/mobile_login_screen.dart';
import 'responsive/tablet_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    statusBarColor(color: Colors.grey[100]);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _listener,
      builder: (context, state) {
        return UnFocusedKeyboard(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            // appBar: _buildAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p26),
              child: Form(
                key: _formKey,
                child: Responsive(
                  mobile: MobileLoginScreen(
                    userName: userName,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                  tablet: TabletLoginScreen(
                    userName: userName,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                  desktop: TabletLoginScreen(
                    userName: userName,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _listener(context, state) {
    if (state is LoginSuccessState) {
      ToastAndSnackBar.toastSuccess(
          message: AppStrings.verificationCompletedSuccessfully.tr());
      MagicRouterName.navigateAndPopAll(RoutesNames.mainLayoutApp);
    }
    if (state is LoginErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await Future.delayed(
        const Duration(seconds: 5),
        () => null,
      );
      // await Future.sync(() => sl<LoginCubit>().get(context).login(LoginRequest(
      //       username: userName.text,
      //       password: password.text,
      //     )));
    }
  }
}

/// responsive
