import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../educational_levels/presentation/widgets/view_image_widget.dart';

class CardCourseWidget extends StatelessWidget {
  const CardCourseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(AppPadding.p12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Column(
            children: [
              const Expanded(
                flex: 5,
                child: ImageWidget(
                  imagePath:
                      'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: AppSize.s5),
                        Text(
                          'الكورس الاول للمرحلة الاوالى',
                          style: context.displayMedium
                              .copyWith(color: ColorManager.primary),
                        ),
                        const SizedBox(height: AppSize.s5),
                        Text(
                          'المدرس الاول',
                          style: context.bodySmall
                              .copyWith(color: ColorManager.textGray),
                        ),
                        const SizedBox(height: AppSize.s5),
                        ElevatedButton(
                            onPressed: () {
                              ///TODO:
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                              minimumSize: const Size.fromHeight(40.0),
                              backgroundColor: ColorManager.secondary,
                            ),
                            child: Text(
                              '4 \$',
                              textAlign: TextAlign.center,
                              style: context.displayMedium.copyWith(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
