import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sudanet_app/widgets/custom_loading_widget.dart';

import '../../../../app/injection_container.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: state is GetCategoriesLoadingState ||
                    state is GetCoursesLoadingState ||
                    state is GetSliderLoadingState
                ? const CustomLoadingScreen()
                : BodyHomeWidget(
                    cubit: sl<HomeCubit>().get(context),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async => await Future.sync(() {
        sl<HomeCubit>().get(context)
          ..getCategories()
          ..getCourses()
          ..getSlider();
      });

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

class BodyHomeWidget extends StatelessWidget {
  final HomeCubit cubit;

  const BodyHomeWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics:
          const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          if (cubit.sliderItems.isNotEmpty)
            SliderWidget(slidersItems: cubit.sliderItems),
          const SizedBox(height: 20.0),
          CategoriesWidget(cubit: cubit),
          const SizedBox(height: 20.0),
          CoursesWidget(cubit: cubit),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  List<String> imageSlider() {
    return [
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
    ];
  }
}
