import 'package:flutter/material.dart';

import '../widgets/custom_nav_bar.dart';

class MainLayoutAppScreen extends StatefulWidget {
  const MainLayoutAppScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutAppScreen> createState() => _MainLayoutAppScreenState();
}

class _MainLayoutAppScreenState extends State<MainLayoutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomNavBar(),
    );
  }
}
