import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/app_manage/strings_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/main_layout_home/presentation/cubit/nav_bar_cubit.dart';

import '../../../../core/service/locale_service/manager/locale_cubit.dart';
import '../../../../widgets/bottom_navy_bar.dart';
import '../widgets/custom_nav_bar_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final menuItemList = <MenuItem>[
    MenuItem(
      0,
      icon: FontAwesomeIcons.houseChimney,
      text: AppStrings.home.tr(),
    ),
    MenuItem(
      1,
      icon: Icons.grid_view_sharp,
      text: AppStrings.educationalLevels.tr(),
    ),
    MenuItem(
      2,
      icon: FontAwesomeIcons.book,
      text: AppStrings.subjects.tr(),
    ),
    MenuItem(
      3,
      icon: Icons.person_2,
      text: AppStrings.profile.tr(),
    ),
  ];

  late List<BottomNavyBarItem> items = menuItemList.map((e) {
    return BottomNavyBarItem(
      icon: Icon(e.icon),
      title: Text(e.text),
      activeColor: ColorManager.primary,
      inactiveColor: Colors.grey,
      backgroundColorItem: ColorManager.secondary,
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final cubit = NavBarCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                return Localizations.override(
                  context: context,
                  locale: state.locale,
                  child: CustomNavBarWidget(
                    currentIndex: cubit.currentIndex,
                    onItemSelected: (int index) => cubit.changeIndex(index),
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                        icon: const Icon(FontAwesomeIcons.houseChimney),
                        title: Text(AppStrings.home.tr()),
                        activeColor: ColorManager.primary,
                        inactiveColor: Colors.grey,
                        backgroundColorItem: ColorManager.secondary,
                      ),
                      BottomNavyBarItem(
                        icon: const Icon(Icons.grid_view_sharp),
                        title: Text(AppStrings.educationalLevels.tr()),
                        activeColor: ColorManager.primary,
                        inactiveColor: Colors.grey,
                        backgroundColorItem: ColorManager.secondary,
                      ),
                      BottomNavyBarItem(
                        icon: const Icon(FontAwesomeIcons.book),
                        title: Text(AppStrings.subjects.tr()),
                        activeColor: ColorManager.primary,
                        inactiveColor: Colors.grey,
                        backgroundColorItem: ColorManager.secondary,
                      ),
                      BottomNavyBarItem(
                        icon: const Icon(Icons.person_2),
                        title: Text(AppStrings.profile.tr()),
                        activeColor: ColorManager.primary,
                        inactiveColor: Colors.grey,
                        backgroundColorItem: ColorManager.secondary,
                      ),
                    ],
                  ),
                );
              },
            ),
            body: cubit.screens()[cubit.currentIndex],
          );
        },
      ),
    );
  }
}

class MenuItem {
  const MenuItem(this.index, {required this.icon, required this.text});

  final int index;

  final IconData icon;
  final String text;
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: context.bodyLarge.copyWith(color: Colors.black),
      ),
    );
  }
}

class Massages extends StatelessWidget {
  const Massages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Massages',
        style: context.bodyLarge.copyWith(color: Colors.black),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: context.bodyLarge.copyWith(color: Colors.black),
      ),
    );
  }
}
