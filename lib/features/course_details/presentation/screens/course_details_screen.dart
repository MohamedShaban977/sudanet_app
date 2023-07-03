import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/core/routes/magic_router.dart';
import 'package:sudanet_app/widgets/toast_and_snackbar.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_error_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/custom_video_widget.dart';
import '../../domain/entities/course_details_entity.dart';
import '../cubit/course_details_cubit.dart';
import 'purchase_course_widget.dart';

///
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
      listener: _listener,
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
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
        return ModalProgressHUD(
          inAsyncCall: state is GetCourseLectureDetailsLoadingState,
          child: CustomVideoWidget(
            videoId: courseDetails.youtubeID,
            builder: (BuildContext context, Widget player) {
              return BodyScreen(
                player: player,
                courseDetails: courseDetails,
              );
            },
          ),
        );
      },
    );
  }

  void _listener(context, state) {
    if (state is GetCourseDetailsSuccessState) {
      courseDetails = state.response.data!;
    }
    if (state is GetCourseLectureDetailsSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);

      MagicRouterName.navigateTo(RoutesNames.courseLectures, arguments: {
        'courseLectures': state.response.data!,
        'initVideoID': courseDetails.youtubeID,
      });
    }

    if (state is GetCourseLectureDetailsErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }

    if (state is BuyCourseErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
      MagicRouter.pop();
    }
    if (state is BuyCourseSuccessState) {
      courseDetails.purchased = true;
      ToastAndSnackBar.toastSuccess(message: state.response.message);
    }
  }
}

///
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

///
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

            /// Name course
            Text(courseDetails.name,
                style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),

            /// description course
            Text(courseDetails.description, style: context.bodyMedium),
            const SizedBox(height: 20.0),

            /// teacherName course
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

            /// price and currency Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      '${courseDetails.price}    ${courseDetails.currencyName}',
                      style: context.displayLarge
                          .copyWith(color: ColorManager.textGray)),
                  SizedBox(
                    width: 150.0,
                    height: 46.0,
                    child: Visibility(
                      visible: courseDetails.purchased,
                      replacement: ElevatedButton(
                          onPressed: () => PurchaseCourses.show(
                                context,
                                courseId: courseDetails.id,
                                isAlert: false,
                              ),
                          child: Text(AppStrings.purchase.tr())),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            disabledForegroundColor: ColorManager.primary,
                            disabledBackgroundColor: ColorManager.white,
                            elevation: 0.0,
                            side: const BorderSide(
                              color: ColorManager.secondary,
                            ),
                          ),
                          onPressed: null,
                          child: Text(AppStrings.buyingSucceeded.tr())),
                    ),
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

///
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
            Text(AppStrings.contentCourse.tr(),
                style:
                    context.bodyLarge.copyWith(color: ColorManager.textGray)),
            const SizedBox(height: 20.0),
            // Text('(7) حصص * (10) فيديوهات * 10س . 54د',
            //     style: context.bodyMedium),
            const SizedBox(height: 20.0),
            ...List.generate(
              courseDetails.courseLectures.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.lightGrey),
                ),
                child: CustomExpandedTitle(
                  iconLeading: Icon(
                    _checkCoursePurchasedOrIsFree(index)
                        ? FontAwesomeIcons.lockOpen
                        : FontAwesomeIcons.lock,
                    size: 20.0,
                  ),
                  textTitle: courseDetails.courseLectures[index].name,
                  isExpanded: index == 0 ? true : false,
                  onTap: () => sl<CourseDetailsCubit>()
                      .get(context)
                      .getLectureCourseDetails(
                          '${courseDetails.courseLectures[index].id}'),
                  children: [
                    ContentSession(
                      iconLeading: _checkCoursePurchasedOrIsFree(index)
                          ? FontAwesomeIcons.lockOpen
                          : FontAwesomeIcons.lock,
                      title: AppStrings.videos.tr(),
                      count:
                          '${courseDetails.courseLectures[index].videoCount}',
                      iconTrailing: FontAwesomeIcons.play,
                    ),
                    ContentSession(
                      iconLeading: _checkCoursePurchasedOrIsFree(index)
                          ? FontAwesomeIcons.lockOpen
                          : FontAwesomeIcons.lock,
                      title: AppStrings.files.tr(),
                      count: '${courseDetails.courseLectures[index].fileCount}',
                      iconTrailing: FontAwesomeIcons.fileArrowDown,
                    ),
                    ContentSession(
                      iconLeading: _checkCoursePurchasedOrIsFree(index)
                          ? FontAwesomeIcons.lockOpen
                          : FontAwesomeIcons.lock,
                      title: AppStrings.exam.tr(),
                      count: '${courseDetails.courseLectures[index].examCount}',
                      iconTrailing: FontAwesomeIcons.solidCircleQuestion,
                    ),
                  ],
                ),
              ),
            ),

            if (courseDetails.courseLectures.isEmpty)
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(AppStrings.nosDataAvailable.tr(),
                    textAlign: TextAlign.center,
                    style: context.bodyLarge
                        .copyWith(color: ColorManager.textGray)),
              ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  bool _checkCoursePurchasedOrIsFree(int index) {
    return courseDetails.courseLectures[index].isFree ||
        courseDetails.purchased;
  }
}

///
class ContentSession extends StatelessWidget {
  final IconData iconLeading;
  final IconData iconTrailing;
  final String count;
  final String title;

  const ContentSession({
    super.key,
    required this.iconLeading,
    required this.iconTrailing,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      return Container(
        width: con.maxWidth,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  iconLeading,
                  // courseDetails.courseLectures[index].isFree
                  //     ? FontAwesomeIcons.lockOpen
                  //     : FontAwesomeIcons.lock,
                  size: 20.0,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 20.0),
                Row(
                  children: [
                    Text(
                      count,
                      style: context.titleMedium.copyWith(
                        color: ColorManager.primary,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      title,
                      // AppStrings.videos.tr(),
                      style: context.titleMedium.copyWith(
                        color: ColorManager.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  iconTrailing,
                  // FontAwesomeIcons.play,
                  size: 20.0,
                  color: ColorManager.primary,
                ),
              ],
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Icon(
          //             courseDetails.courseLectures[index].isFree
          //                 ? FontAwesomeIcons.lockOpen
          //                 : FontAwesomeIcons.lock,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //           const SizedBox(width: 20.0),
          //           Row(
          //             children: [
          //               Text(
          //                 '4',
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //               const SizedBox(width: 10.0),
          //               Text(
          //                 AppStrings.videos.tr(),
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Spacer(),
          //           const Icon(
          //             FontAwesomeIcons.play,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 10.0),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           const Icon(
          //             FontAwesomeIcons.lockOpen,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //           const SizedBox(width: 20.0),
          //           Row(
          //             children: [
          //               Text(
          //                 '4',
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //               const SizedBox(width: 10.0),
          //               Text(
          //                 AppStrings.files.tr(),
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Spacer(),
          //           const Icon(
          //             FontAwesomeIcons.fileArrowDown,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 10.0),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           const Icon(
          //             FontAwesomeIcons.lockOpen,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //           const SizedBox(width: 20.0),
          //           Row(
          //             children: [
          //               Text(
          //                 '4',
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //               const SizedBox(width: 10.0),
          //               Text(
          //                 AppStrings.exam.tr(),
          //                 style: context.titleMedium.copyWith(
          //                   color: ColorManager.primary,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Spacer(),
          //           const Icon(
          //             FontAwesomeIcons.solidCircleQuestion,
          //             size: 20.0,
          //             color: ColorManager.primary,
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 10.0),
          //   ],
          // ),
        ),
      );
    });
  }
}

///
class CustomExpandedTitle extends StatefulWidget {
  final String textTitle;

  final Icon iconLeading;
  final List<Widget> children;
  final void Function()? onTap;

  final bool isExpanded;

  const CustomExpandedTitle(
      {Key? key,
      required this.textTitle,
      required this.iconLeading,
      required this.children,
      this.isExpanded = false,
      this.onTap})
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
    return InkWell(
      onTap: widget.onTap,
      child: ExpansionTile(
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
        children: widget.children,
      ),
    );
  }
}
