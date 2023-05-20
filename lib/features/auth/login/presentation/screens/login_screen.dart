import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/theme_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../../data/models/login_request.dart';
import '../cubit/login_cubit.dart';
import '../manger/user_secure_storage.dart';
import 'responsive/mobile_login_screen.dart';
import 'responsive/tablet_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? guidId;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMacID();
  }

  getMacID() async {
    String? res = await UserSecureStorage.getMacId();
    if (res != null) {
      guidId = res;
    }
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
                    email: email,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                  tablet: TabletLoginScreen(
                    email: email,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                  desktop: TabletLoginScreen(
                    email: email,
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

  Future<void> _listener(context, state) async {
    if (state is LoginSuccessState) {
      guidId = state.response.data!.guid;
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      MagicRouterName.navigateAndPopAll(RoutesNames.mainLayoutApp);
    }
    if (state is LoginErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

/*

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
*/

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await Future.sync(
          () async => sl<LoginCubit>().get(context).login(LoginRequest(
                email: email.text,
                password: password.text,
                macAddress: guidId,
              )));
    }
  }
}

/// responsive
