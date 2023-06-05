import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/features/course_details/presentation/cubit/course_details_cubit.dart';
import 'package:sudanet_app/widgets/custom_app_bar_widget.dart';
import 'package:sudanet_app/widgets/custom_error_widget.dart';
import 'package:sudanet_app/widgets/custom_loading_widget.dart';

import '../../../../widgets/custom_video_widget.dart';
import '../../domain/entities/course_details_entity.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String id;

  const CourseDetailsScreen({super.key, required this.id});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with WidgetsBindingObserver {
  final String videoId = 'W9xxF_DIt6g';
  bool _isInForeground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    if (kDebugMode) {
      print('isInForeground : $_isInForeground');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late CourseDetailsEntity courseDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
      listener: (context, state) {
        if (state is GetCourseDetailsSuccessState) {
          courseDetails = state.response.data!;
        }
      },
      builder: (context, state) {
        if (state is GetCourseDetailsLoadingState) {
          return const Scaffold(body: CustomLoadingScreen());
        }
        if (state is GetCourseDetailsErrorState) {
          return const Scaffold(body: CustomErrorWidget());
          // if (courseDetails == null) {
          //
          // }
        }
        return CustomVideoWidget(
          videoId: courseDetails.youtubeID,
          builder: (BuildContext context, Widget player) {
            return BodyScreen(
              player: player,
              courseDetails: courseDetails,
            );
          },
        );
      },
    );
  }
}

class BodyScreen extends StatelessWidget {
  final Widget player;
  final CourseDetailsEntity courseDetails;

  const BodyScreen({
    super.key,
    required this.player,
    required this.courseDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: courseDetails.categoryName),
      body: ListView(children: [
        player,
        CardDetailsCourseWidget(courseDetails: courseDetails),
        const SizedBox(height: 20.0),
        CardContentCourseWidget(courseDetails: courseDetails),
      ]),
    );
  }
}

class CardDetailsCourseWidget extends StatelessWidget {
  final CourseDetailsEntity courseDetails;

  const CardDetailsCourseWidget({
    super.key,
    required this.courseDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(courseDetails.name,
                style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),
            Text(courseDetails.description, style: context.bodyMedium),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.chalkboardUser,
                    // size: 30.0,
                    color: ColorManager.grey,
                  ),
                  const SizedBox(width: 20.0),
                  Text(courseDetails.teacherName)
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('200   ${courseDetails.currencyName}',
                      style: context.displayLarge
                          .copyWith(color: ColorManager.textGray)),
                  SizedBox(
                    width: 150.0,
                    height: 46.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {},
                        child: const Text('شراء')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardContentCourseWidget extends StatelessWidget {
  final CourseDetailsEntity courseDetails;

  const CardContentCourseWidget({
    super.key,
    required this.courseDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('محتوى المنهج',
                style:
                    context.bodyLarge.copyWith(color: ColorManager.textGray)),
            const SizedBox(height: 10.0),
            Text('(7) حصص * (10) فيديوهات * 10س . 54د',
                style: context.bodyMedium),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.lightGrey),
              ),
              child: const CustomExpandedTitle(
                iconLeading: Icon(
                  FontAwesomeIcons.lockOpen,
                  size: 20.0,
                ),
                textTitle: 'الحصه الاولى - مقدمه عن المنهج',
                isExpanded: true,
                children: [],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.lightGrey),
              ),
              child: const CustomExpandedTitle(
                iconLeading: Icon(
                  FontAwesomeIcons.lock,
                  size: 20.0,
                ),
                textTitle: 'الحصه الاولى - مقدمه عن المنهج',
                children: [],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.lightGrey),
              ),
              child: const CustomExpandedTitle(
                iconLeading: Icon(
                  FontAwesomeIcons.lock,
                  size: 20.0,
                ),
                textTitle: 'الحصه الاولى - مقدمه عن المنهج',
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpandedTitle extends StatefulWidget {
  final String textTitle;

  final Icon iconLeading;
  final List<Widget> children;

  final bool isExpanded;

  const CustomExpandedTitle(
      {Key? key,
      required this.textTitle,
      required this.iconLeading,
      required this.children,
      this.isExpanded = false})
      : super(key: key);

  @override
  State<CustomExpandedTitle> createState() => _CustomExpandedTitleState();
}

class _CustomExpandedTitleState extends State<CustomExpandedTitle>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  _setExpanded([bool? value]) {
    setState(() {
      _isExpanded = value ?? widget.isExpanded;
    });
  }

  @override
  void initState() {
    _setExpanded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.textTitle,
          style: context.displayMedium.copyWith(
              fontWeight: _isExpanded ? FontWeight.w700 : FontWeight.normal,
              color: _isExpanded
                  ? ColorManager.primary
                  : context.displayMedium.color)),
      // collapsedTextColor: ColorManager.primary,
      // textColor: ColorManager.primary,
      backgroundColor: ColorManager.secondary,
      initiallyExpanded: _isExpanded,
      collapsedIconColor: ColorManager.textGray,
      iconColor: ColorManager.primary,
      leading: widget.iconLeading,
      // const Icon(
      //   FontAwesomeIcons.lockOpen,
      //   size: 20.0,
      // ),
      onExpansionChanged: (value) => _setExpanded(value),
      // trailing: AnimatedIcon(
      //   icon: AnimatedIcons.add_event,
      //   progress: _controller,
      //   semanticLabel: 'Show menu',
      // ),
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == const ValueKey('icon1')
              ? Tween<double>(begin: 1, end: 0).animate(anim)
              : Tween<double>(begin: 0, end: 1).animate(anim),
          child: ScaleTransition(scale: anim, child: child),
        ),
        child: _isExpanded
            ? const Icon(Icons.remove, key: ValueKey('icon1'))
            : const Icon(Icons.add, key: ValueKey('icon2')),
      ),
      children: [
        LayoutBuilder(builder: (context, con) {
          return Container(
            width: con.maxWidth,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          FontAwesomeIcons.lockOpen,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          '4 فيديوهات',
                          style: context.titleMedium.copyWith(
                            color: ColorManager.primary,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          FontAwesomeIcons.play,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          FontAwesomeIcons.lockOpen,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          '4 ملفات',
                          style: context.titleMedium.copyWith(
                            color: ColorManager.primary,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          FontAwesomeIcons.fileArrowDown,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          FontAwesomeIcons.lockOpen,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          '1 امتحان',
                          style: context.titleMedium.copyWith(
                            color: ColorManager.primary,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          FontAwesomeIcons.solidCircleQuestion,
                          size: 20.0,
                          color: ColorManager.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
