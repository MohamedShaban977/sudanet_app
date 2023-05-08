import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_manage/color_manager.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);

  static List<Widget> screens() {
    return [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];
  }

  // List<String> listTitleAppBar() {
  //   return [
  //     'Home',
  //     'Lists',
  //     'Scan',
  //     'Search',
  //     'Profile',
  //   ];
  // }

  int currentTab = 0; // to keep track of active tab index
  Widget currentScreen = screens().first; // Our first view in viewport
  // String titleAppbar = 'Home';

  void changeIndex(int index) {
    currentTab = index;
    // titleAppbar = listTitleAppBar()[currentTab];
    currentScreen = screens()[currentTab];
    emit(NavBarChangeState());
  }

  Color inactiveColor = ColorManager.nonSelectNavBar;
  Color inactiveColorText = ColorManager.textGray;

  Color changeColorIcon(int index, {Color activeColor = ColorManager.primary}) {
    return currentTab == index ? activeColor : inactiveColor;
  }

  Color changeColorText(int index, {Color activeColor = ColorManager.primary}) {
    return currentTab == index ? activeColor : inactiveColorText;
  }
}
