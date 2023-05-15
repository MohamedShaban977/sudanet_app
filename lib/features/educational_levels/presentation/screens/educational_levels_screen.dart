import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/app_manage/strings_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/core/responsive/responsive.dart';

import '../../../../core/app_manage/color_manager.dart';

class EducationalLevelsScreen extends StatelessWidget {
  const EducationalLevelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                AppStrings.viewAllEducationalLevels.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorManager.primary,
                    ),
              ),
            ),
            // Column(
            //   children: List.generate(
            //     10,
            //     (index) => const CardEducationalLevelsWidget(),
            //   ),
            // ),
            GridView.count(
              crossAxisCount:
                  Responsive.isMobile(context) || Responsive.isMobileS(context)
                      ? 1
                      : Responsive.isTablet(context)
                          ? 2
                          : 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              childAspectRatio: Responsive.isMobile(context)
                  ? 2.6
                  : Responsive.isMobileS(context)
                      ? 2.0
                      : Responsive.isTablet(context)
                          ? 1.1
                          : 1.0,

              // Responsive.isMobile(context) ? 2.6 : 1.3,
              // padding: const EdgeInsets.all(4.0),
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                10,
                (index) => LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  return Responsive(
                    mobile: CardEducationalLevelsRowWidget(
                      index: index,
                      height: constraints.maxHeight,
                    ),
                    tablet: CardEducationalLevelsColumnWidget(
                      index: index,
                      width: constraints.maxWidth,
                    ),
                    desktop: CardEducationalLevelsColumnWidget(
                      index: index,
                      width: constraints.maxWidth,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 5.0,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(AppStrings.educationalLevels.tr(),
          style: context.displayLarge.copyWith(
              color: ColorManager.textGray, fontWeight: FontWeight.w700)),
    );
  }
}

class CardEducationalLevelsRowWidget extends StatelessWidget {
  final int index;
  final double height;
  final double? width;

  const CardEducationalLevelsRowWidget({
    super.key,
    required this.index,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: IntrinsicHeight(
                child: Image.network(
                  'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
                  fit: BoxFit.fill,
                  height: height,
                  width: width,
                  gaplessPlayback: true,
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ViewInfoDataEducationalWidget(index: index),
                )),
          ],
        ),
      ),
    );
  }
}

class ViewInfoDataEducationalWidget extends StatelessWidget {
  const ViewInfoDataEducationalWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'المرحلة ${index + 1}',
          style: context.displayLarge.copyWith(color: ColorManager.primary),
        ),
        Text(
          '6 مواد',
          style: context.displaySmall.copyWith(color: ColorManager.textGray),
        ),
        SizedBox(
          width: context.width,
          height: 50.0,
          child: ElevatedButton(
              onPressed: () {
                ///TODO:
              },
              child: Text(AppStrings.findAvailableSubjects.tr())),
        ),
      ],
    );
  }
}

class CardEducationalLevelsColumnWidget extends StatelessWidget {
  final int index;
  final double? height;
  final double? width;

  const CardEducationalLevelsColumnWidget({
    super.key,
    required this.index,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: IntrinsicHeight(
                child: Image.network(
                  'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
                  fit: BoxFit.fill,
                  // height: height,
                  width: width,
                  gaplessPlayback: true,
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Text(
                        'المرحلة ${index + 1}',
                        style: context.displayLarge
                            .copyWith(color: ColorManager.primary),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '6 مواد',
                        style: context.displaySmall
                            .copyWith(color: ColorManager.textGray),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: context.width,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () {
                              ///TODO:
                            },
                            child: Text(AppStrings.findAvailableSubjects.tr())),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
