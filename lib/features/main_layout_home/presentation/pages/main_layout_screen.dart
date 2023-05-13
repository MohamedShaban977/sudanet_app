import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/app_manage/strings_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

import '../widgets/custom_nav_bar_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    const Home(),
    const User(),
    const Massages(),
    const Settings(),
  ];

  final menuItemList = <MenuItem>[
    MenuItem(0,
        icon: FontAwesomeIcons.houseChimney, text: AppStrings.home.tr()),
    MenuItem(1,
        icon: Icons.grid_view_sharp, text: AppStrings.educationalLevels.tr()),
    MenuItem(2, icon: FontAwesomeIcons.book, text: AppStrings.subjects.tr()),
    MenuItem(3, icon: Icons.person_2, text: AppStrings.profile.tr()),
  ];

  late List<BottomNavyBarItem> items = menuItemList
      .map(
        (e) => BottomNavyBarItem(
          icon: Icon(e.icon),
          title: Text(e.text),
          activeColor: ColorManager.primary,
          inactiveColor: Colors.grey,
          backgroundColorItem: ColorManager.secondary,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        spreadRadius: 5.0,
        blurRadius: 5.0,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
        // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        // backgroundColor: ColorManager.secondary,
        items:
            items, /* [
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.houseChimney, size: 23),
            title: Text(AppStrings.home.tr()),
            activeColor: ColorManager.primary,
            inactiveColor: Colors.grey,
            backgroundColorItem: ColorManager.secondary,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.grid_view_sharp, size: 25),
            title: Text(AppStrings.educationalLevels.tr()),
            activeColor: ColorManager.primary,
            inactiveColor: Colors.grey,
            backgroundColorItem: ColorManager.secondary,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.book, size: 23),
            title: Text(AppStrings.subjects.tr()),
            activeColor: ColorManager.primary,
            inactiveColor: Colors.grey,
            backgroundColorItem: ColorManager.secondary,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person_2, size: 25),
            title: Text(AppStrings.profile.tr()),
            activeColor: ColorManager.primary,
            inactiveColor: Colors.grey,
            backgroundColorItem: ColorManager.secondary,
          ),
        ],*/
      ),
      body: screens[currentIndex],
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

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'User',
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
