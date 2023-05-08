import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../core/app_manage/color_manager.dart';
import 'argon_button.dart';

class CustomButtonWithLoading extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final double borderRadius;

  final Future Function() onTap;

  final Color? color, textColors;

  const CustomButtonWithLoading(
      {Key? key,
      required this.text,
      required this.onTap,
      this.height,
      this.width,
      this.color,
      this.textColors,
      this.borderRadius = 4.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: height ?? 50.0,
      roundLoadingShape: true,
      onTap: (startLoading, stopLoading, ButtonState btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          await onTap();
          stopLoading();
        } else {
          stopLoading();
        }
      },
      loader: const Padding(
        padding: EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: ColorManager.primary,
            ),
          ),
        ),
      ),
      borderRadius: borderRadius,
      color: color ?? ColorManager.primary,
      child: Text(
        text,
        style: context.labelLarge.copyWith(color: textColors ?? Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
