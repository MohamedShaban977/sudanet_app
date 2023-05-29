import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/features/profile/presentation/screens/profile_screen.dart';

import '../../../categories/presentation/screens/categories_screen.dart';
import '../../../courses/presentation/screens/courses_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens() => [
        const HomeScreen(),
        const CategoriesScreen(),
        const CoursesScreen(),
        const ProfileScreen(),
      ];

  int currentIndex = 0; // to keep track of active tab index
  // Widget currentScreen = screens().first; // Our first view in viewport

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
  }
}
