import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/injection_container.dart';
import '../../features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import '../../features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/sign_up/presentation/cubit/signup_cubit.dart';
import '../../features/auth/sign_up/presentation/screens/signup_screen.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/contact_info/presentation/cubit/contact_info_cubit.dart';
import '../../features/contact_info/presentation/screens/contact_info_screen.dart';
import '../../features/course_details/presentation/cubit/course_details_cubit.dart';
import '../../features/course_details/presentation/screens/course_details_screen.dart';
import '../../features/course_details/presentation/screens/course_lecture_details.dart';
import '../../features/courses/presentation/cubit/courses_cubit.dart';
import '../../features/courses_by_category/presentation/cubit/courses_by_category_cubit.dart';
import '../../features/courses_by_category/presentation/screens/corses_by_category_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/main_layout_home/presentation/screens/main_layout_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../app_manage/strings_manager.dart';
import 'magic_router.dart';
import 'routes_name.dart';
import 'routes_request.dart';

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
        ServiceLocator.initHomeGetIt();
        ServiceLocator.initCoursesGetIt();
        ServiceLocator.initCategoriesGetIt();
        return MagicRouter.pageRoute(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<HomeCubit>()
                ..getCategories()
                ..getCourses()
                ..getSlider(),
            ),
            BlocProvider(
              create: (context) => sl<CoursesCubit>()..getAllCourses(),
            ),
            BlocProvider(
              create: (context) => sl<CategoriesCubit>()..getCategories(),
            ),
          ],
          child: const MainLayoutScreen(),
        ));

      // loginRoute
      case RoutesNames.coursesByCategoryScreen:
        ServiceLocator.initCoursesByCategoryGetIt();
        final RouteRequest res =
            RouteRequest.fromJson(settings.arguments! as Map<String, dynamic>);

        return MagicRouter.pageRoute(BlocProvider(
          create: (context) =>
              sl<CoursesByCategoryCubit>()..getCoursesByCategoryId(res.id!),
          child: CoursesByCategoryScreen(
            categoryId: res.id!,
          ),
        ));

      case RoutesNames.contactInfo:
        ServiceLocator.initGetContactInfoGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ContactInfoCubit>()..getContactInfo(),
          child: const ContactInfoScreen(),
        ));
      case RoutesNames.courseDetails:
        ServiceLocator.initCoursesDetailsGetIt();

        final RouteRequest res =
            RouteRequest.fromJson(settings.arguments! as Map<String, dynamic>);

        return MagicRouter.pageRoute(BlocProvider(
          create: (context) =>
              sl<CourseDetailsCubit>()..getCourseDetails(res.id!),
          child: CourseDetailsScreen(id: res.id!),
        ));

      case RoutesNames.courseLectures:
        ServiceLocator.initCoursesDetailsGetIt();

        // final res = settings.arguments! as CourseLectureDetailsEntity;
        final res = settings.arguments! as Map<String, dynamic>;

        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<CourseDetailsCubit>(),
          child: CourseLecturesScreen(
            courseLectureDetails: res['courseLectures'],
            initVideoID: res['initVideoID'],
          ),
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
