import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../../../widgets/custom_video_widget.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return CustomVideoWidget(
      videoId: videoId,
      builder: (BuildContext context, Widget player) {
        return BodyScreen(
          player: player,
        );
      },
    );
  }
}

class BodyScreen extends StatelessWidget {
  final Widget player;

  BodyScreen({
    super.key,
    required this.player,
  });

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        player,
        Card(
          elevation: 0.1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('اللغه العربيه الصف الاول الابتدائى الترم الاول',
                    style: context.bodyLarge
                        .copyWith(color: ColorManager.primary)),
                const SizedBox(height: 20.0),
                Text('اللغه العربيه الصف الاول الابتدائى الترم الاول',
                    style: context.bodyMedium),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.chalkboardUser,
                        // size: 30.0,
                        color: ColorManager.grey,
                      ),
                      SizedBox(width: 20.0),
                      Text('أ/ اسم الاستاذ')
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
                      Text('200   جنيه',
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
        ),
        const SizedBox(height: 20.0),
        Card(
          elevation: 0.1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('محتوى المنهج',
                    style: context.bodyLarge
                        .copyWith(color: ColorManager.textGray)),
                const SizedBox(height: 10.0),
                Text('(7) حصص * (10) فيديوهات * 10س . 54د',
                    style: context.bodyMedium),
                const SizedBox(height: 20.0),
                StatefulBuilder(builder: (context, setState) {
                  return ExpansionTile(
                    title: Text('الحصه الاولى - مقدمه عن المنهج',
                        style: context.displayMedium.copyWith(
                          fontWeight:
                              _isExpanded ? FontWeight.w700 : FontWeight.normal,
                        )),
                    collapsedTextColor: ColorManager.primary,
                    backgroundColor: ColorManager.secondary,

                    collapsedIconColor: ColorManager.textGray,
                    iconColor: ColorManager.primary,
                    leading: const Icon(
                      FontAwesomeIcons.lockOpen,
                      size: 20.0,
                    ),
                    onExpansionChanged: (value) {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('الحصه الاولى - مقدمه عن المنهج',
                                  style: context.displayMedium),
                              Text('الحصه الاولى - مقدمه عن المنهج',
                                  style: context.displayMedium),
                              Text('الحصه الاولى - مقدمه عن المنهج',
                                  style: context.displayMedium),
                              Text('الحصه الاولى - مقدمه عن المنهج',
                                  style: context.displayMedium),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
