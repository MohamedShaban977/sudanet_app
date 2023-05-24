import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../widgets/categories_widget.dart';
import '../widgets/courses_widget.dart';
import '../widgets/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is GetCategoriesLoadingState ||
                state is GetCoursesLoadingState ||
                state is GetSliderLoadingState,
            child: SingleChildScrollView(
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
        },
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
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        ]),
      ),
    );
  }
}
