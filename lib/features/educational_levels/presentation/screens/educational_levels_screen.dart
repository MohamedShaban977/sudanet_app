import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/app_manage/strings_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';

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
                    color: ColorManager.primary,),
              ),
            ),
            Column(
              children: List.generate(
                  10,
                  (index) => Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                                    height: 130,
                                    gaplessPlayback: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              child:  Text(
                                                  AppStrings.findAvailableSubjects.tr())),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )),
            )
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
      title:
          Text(AppStrings.educationalLevels.tr(), style: context.displayLarge.copyWith(color: ColorManager.textGray,fontWeight: FontWeight.w700)),
    );
  }
}
