import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../widgets/categories_widget.dart';
import '../widgets/courses_widget.dart';
import '../widgets/slider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20.0),
            SliderWidget(),
            SizedBox(height: 20.0),
            CategoriesWidget(),
            SizedBox(height: 20.0),
            CoursesWidget(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 20),
      child: AppBar(
        // elevation: AppSize.s5,
        centerTitle: false,
        backgroundColor: ColorManager.background,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              ImageAssets.logoImg,
              alignment: Alignment.center,
              height: kToolbarHeight - 5,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'تسجيل الدخول',
                style: context.displaySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
