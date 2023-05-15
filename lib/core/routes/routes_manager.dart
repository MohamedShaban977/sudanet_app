import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:sudanet_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:sudanet_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:sudanet_app/features/auth/sign_up/presentation/cubit/signup_cubit.dart';
import 'package:sudanet_app/features/auth/sign_up/presentation/screens/signup_screen.dart';

import '../../app/injection_container.dart';
import '../../features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import '../../features/main_layout_home/presentation/screens/main_layout_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../app_manage/strings_manager.dart';
import 'magic_router.dart';
import 'routes_name.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.initialRoute:
        return MagicRouter.pageRoute(const SplashScreen());

      // loginRoute
      case RoutesNames.loginRoute:
        ServiceLocator.initLoginGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: const LoginScreen(),
        ));

      // loginRoute
      case RoutesNames.signupRoute:
        ServiceLocator.initSignupGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<SignUpCubit>(),
          child: const SignupScreen(),
        ));

      // loginRoute
      case RoutesNames.forgetPasswordRoute:
        ServiceLocator.initForgetPasswordGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ForgetPasswordCubit>(),
          child: const ForgetPasswordScreen(),
        ));
      // loginRoute
      case RoutesNames.mainLayoutApp:
        // ServiceLocator.initForgetPasswordGetIt();
        return MagicRouter.pageRoute(const MainLayoutScreen());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MagicRouter.pageRoute(Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    ));
  }
}
