import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app/core/app_manage/assets_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(ImageAssets.homeBanner3),
            const SizedBox(height: 40.0),
            Text(
              'معلومات عنا',
              style: context.bodyLarge.copyWith(color: ColorManager.primary),
            ),
            const SizedBox(height: 20.0),
            Text(
              'about',
              style: context.titleLarge,
            ),
            const SizedBox(height: 40.0),
            Text(
              'سياسة الخصوصيه',
              style: context.bodyLarge.copyWith(color: ColorManager.primary),
            ),
            const SizedBox(height: 20.0),
            Text(
              'terms',
              style: context.titleLarge,
            ),
            SizedBox(
                width: context.width * 0.9,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.mapLocationDot,
                              size: 40.0,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'العنوان',
                                      style: context.bodyMedium.copyWith(
                                          color: ColorManager.primary,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان ',
                                      style: context.titleLarge,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const Divider(
                            height: 40.0,
                            thickness: 1.5,
                            endIndent: 20.0,
                            indent: 20.0),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.squareEnvelope,
                              size: 40.0,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'البريد الالكترونى',
                                      style: context.bodyMedium.copyWith(
                                          color: ColorManager.primary,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان ',
                                      style: context.titleLarge,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const Divider(
                            height: 40.0,
                            thickness: 1.5,
                            endIndent: 20.0,
                            indent: 20.0),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.squarePhoneFlip,
                              size: 40.0,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم التلفون',
                                      style: context.bodyMedium.copyWith(
                                          color: ColorManager.primary,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان ',
                                      style: context.titleLarge,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const Divider(
                            height: 40.0,
                            thickness: 1.5,
                            endIndent: 20.0,
                            indent: 20.0),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.squareWhatsapp,
                              size: 40.0,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'العنوان',
                                      style: context.bodyMedium.copyWith(
                                          color: ColorManager.primary,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان العنوان ',
                                      style: context.titleLarge,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
                width: context.width * 0.9,
                height: 100.0,
                child: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.spaceAround,
                      runSpacing: 20.0,
                      runAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      spacing: 10.0,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.squareFacebook,
                            color: Colors.blueAccent,
                            size: 50.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.squareTwitter,
                            color: Colors.blueAccent,
                            size: 50.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.squareInstagram,
                            color: Colors.purple,
                            size: 50.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.squareYoutube,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       FontAwesomeIcons.squareYoutube,
                        //       color: Colors.red,
                        //       size: 50.0,
                        //     )),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
