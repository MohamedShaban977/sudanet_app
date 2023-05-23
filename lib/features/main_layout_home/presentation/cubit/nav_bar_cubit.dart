import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/features/profile/presentation/screens/profile_screen.dart';

import '../../../educational_levels/presentation/screens/educational_levels_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../subjects/presentation/screens/subjects_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens() => [
        const HomeScreen(),
        const EducationalLevelsScreen(),
        const SubjectsScreen(),
        const ProfileScreen(),
      ];

  int currentIndex = 0; // to keep track of active tab index
  // Widget currentScreen = screens().first; // Our first view in viewport

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
  }
}
