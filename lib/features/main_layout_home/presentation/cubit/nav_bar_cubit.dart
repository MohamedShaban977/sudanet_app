import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../educational_levels/presentation/screens/educational_levels_screen.dart';
import '../screens/main_layout_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);

   List<Widget> screens() => [
        const Home(),
        const EducationalLevelsScreen(),
        const Massages(),
        const Settings(),
      ];

  int currentIndex = 0; // to keep track of active tab index
  // Widget currentScreen = screens().first; // Our first view in viewport

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
  }



}
