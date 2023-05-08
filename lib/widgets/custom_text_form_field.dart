import 'package:flutter/material.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../core/app_manage/color_manager.dart';
import '../core/app_manage/values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.onSaved,
      this.controller,
      this.validator,
      required this.label,
      this.keyboardType,
      this.textInputAction,
      this.prefixIcon,
      this.iconData,
      this.onTapIcon,
      this.obscureText = false})
      : super(key: key);

  final String label;

  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  // final int? maxLines, maxLength, minLines;
  final IconData? iconData;
  final Widget? prefixIcon;
  final void Function()? onTapIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.titleLarge),
        const SizedBox(height: AppSize.s12),
        TextFormField(
          cursorColor: ColorManager.secondary,
          cursorHeight: AppSize.s30,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onSaved: onSaved,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,

            suffixIcon: GestureDetector(
              onTap: onTapIcon,
              child: Icon(
                iconData,
                size: 25.0,
                color: ColorManager.grey,
              ),
            ),
            // enabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(AppSize.s4),
            //     borderSide: const BorderSide(
            //       width: AppSize.s1_5,
            //       color: ColorManager.primary,
            //     )),
            // disabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(AppSize.s4),
            //     borderSide: const BorderSide(
            //       width: AppSize.s1_5,
            //       color: ColorManager.textGray,
            //     )),
            // errorBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(AppSize.s4),
            //     borderSide: const BorderSide(
            //       width: AppSize.s1_5,
            //       color: ColorManager.error,
            //     )),
          ),
        ),
      ],
    );
  }
}
