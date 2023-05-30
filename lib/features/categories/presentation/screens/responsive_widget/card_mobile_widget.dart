import 'package:flutter/material.dart';
import 'package:sudanet_app/features/categories/domain/entities/categories_entity.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../widgets/view_info_data_category_widget.dart';

class CardCategoriesMobileWidget extends StatelessWidget {
  final CategoriesEntity category;
  final double height;
  final double? width;

  const CardCategoriesMobileWidget({
    super.key,
    required this.category,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppPadding.p12),
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s11)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ImageWidget(
                width: width,
                height: height,
                imagePath: category.imagePath,
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ViewInfoDataCardCategoriesWidget(category: category),
                )),
          ],
        ),
      ),
    );
  }
}
