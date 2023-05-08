import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../../data/models/signup_request.dart';
import '../cubit/signup_cubit.dart';
import 'responsive/mobile_signup_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    passwordConfirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: _listener,
      builder: (context, state) {
        return UnFocusedKeyboard(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p26),
              child: Form(
                key: _formKey,
                child: Responsive(
                  mobile: MobileSignUpScreen(
                    userName: userName,
                    password: password,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    passwordConfirmation: passwordConfirmation,
                    onTap: _submitLoginButton,
                  ),
                  tablet: MobileSignUpScreen(
                    userName: userName,
                    password: password,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    passwordConfirmation: passwordConfirmation,
                    onTap: _submitLoginButton,
                  ),
                  desktop: MobileSignUpScreen(
                    userName: userName,
                    password: password,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    passwordConfirmation: passwordConfirmation,
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
    if (state is SignUpSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      MagicRouterName.navigateAndPopUntilFirstPage(RoutesNames.loginRoute);
    }
    if (state is SignUpErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.textGray,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await Future.sync(
          () => sl<SignUpCubit>().get(context).signUp(SignUpRequest(
                username: userName.text,
                password: password.text,
                email: email.text,
                lastName: lastName.text,
                firstName: firstName.text,
              )));
    }
  }
}
