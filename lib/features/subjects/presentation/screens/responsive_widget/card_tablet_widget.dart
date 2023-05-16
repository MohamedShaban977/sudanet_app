import 'package:flutter/material.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../widgets/view_image_widget.dart';
import '../../widgets/view_info_data_subjects_widget.dart';

class CardSubjectsTabletWidget extends StatelessWidget {
  final int index;
  final double? height;
  final double? width;

  const CardSubjectsTabletWidget({
    super.key,
    required this.index,
    this.height,
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
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ImageWidget(
                width: width,
                imagePath:
                    'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ViewInfoDataSubjectsWidget(index: index),
                )),
          ],
        ),
      ),
    );
  }
}
