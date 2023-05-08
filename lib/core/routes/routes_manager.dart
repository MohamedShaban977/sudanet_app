import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:sudanet_app/features/auth/login/presentation/screens/login_screen.dart';

import '../../app/injection_container.dart';
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
