import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../main_layout_home/presentation/cubit/nav_bar_cubit.dart';
import 'card_category_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0, end: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المراحل التعليميه الاكثر مشاهده',
                style:
                    context.displayLarge.copyWith(color: ColorManager.textGray),
              ),
              TextButton(
                onPressed: () => NavBarCubit.get(context).changeIndex(1),
                style: TextButton.styleFrom(
                    foregroundColor: ColorManager.secondary,
                    side: const BorderSide(
                        color: ColorManager.secondary, width: 2)),
                child: Text(
                  'المزيد',
                  style:
                      context.titleMedium.copyWith(color: ColorManager.primary),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: List.generate(10, (index) => const CardCategoryWidget()),
          ),
        ),
      ],
    );
  }
}
