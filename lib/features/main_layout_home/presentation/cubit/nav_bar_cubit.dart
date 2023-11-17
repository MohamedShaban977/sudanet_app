import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/features/auth/login/presentation/manger/user_secure_storage.dart';
import 'package:sudanet_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:sudanet_app/widgets/toast_and_snackbar.dart';

import '../../../categories/presentation/screens/categories_screen.dart';
import '../../../contact_info/presentation/screens/contact_info_screen.dart';
import '../../../profile/presentation/screens/user_my_courses_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens() => [
        // const HomeScreen(),
        const CategoriesScreen(),
        const UserMyCoursesScreen(),
        // const CoursesScreen(),
        const ContactInfoScreen(),
        const ProfileScreen(),
      ];

  int currentIndex = 0; // to keep track of active tab index
  // Widget currentScreen = screens().first; // Our first view in viewport

  void changeIndex(int index) {
    if (index == 3 && UserSecureStorage.getToken() == null) {
      ToastAndSnackBar.alertMustBeLogged();
      return;
    }
    currentIndex = index;
    emit(NavBarChangeState());
  }
}
