import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';

import '../cubit/home_cubit.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit().get(context);
        return Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: cubit.imageSlider().length,
              itemBuilder: (_, itemIndex, i) => Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Image.asset(
                  cubit.imageSlider()[itemIndex],
                  fit: BoxFit.fill,
                ),
              ),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                onPageChanged: (index, _) {
                  cubit.onPageChanged(index);
                },
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeIn,
                // enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            // const SizedBox(height: AppSize.s18),
            Positioned(
              bottom: 10.0,
              child: AnimatedSmoothIndicator(
                activeIndex: cubit.yourActiveIndex,
                count: cubit.imageSlider().length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: ColorManager.secondary,
                  dotColor: Colors.white,
                ),
                // textDirection: context.isEnLocale ? TextDirection.ltr : TextDirection.rtl,
              ),
            ),
          ],
        );
      },
    );
  }
}
