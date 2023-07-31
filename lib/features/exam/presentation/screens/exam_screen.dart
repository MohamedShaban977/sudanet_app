import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/app/injection_container.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/exam/domain/entities/exam_entity.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../widgets/custom_error_widget.dart';
import '../cubit/exam_cubit.dart';

class ExamScreen extends StatefulWidget {
  final ExamEntity examEntity;
  final String id;

  const ExamScreen({Key? key, required this.examEntity, required this.id})
      : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  bool _isInForeground = true;

  late ExamEntity _examEntity;

  int _indexQuestion = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    if (kDebugMode) {
      print('isInForeground : $_isInForeground');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        print('=====>resumed');
        sl<ExamCubit>().get(context).getExamQuestionOrPercentage(widget.id);
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
  void initState() {
    _examEntity = widget.examEntity;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (context, state) {
        if (state is GetExamQuestionOrPercentageSuccessState) {
          _examEntity = state.response.data!;
        }

        if (state is SaveAnswerSuccessState) {
          _indexQuestion += 1;
        }
      },
      builder: (context, state) {
        if (state is GetExamQuestionOrPercentageErrorState) {
          return const CustomErrorWidget();
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.0,
            elevation: 0.5,
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_examEntity.examName,
                        style: context.bodyLarge.copyWith(
                            color: ColorManager.primary, fontSize: 22.0),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10.0),
                    Text(
                        '${AppStrings.examDuration.tr()} ${_examEntity.examTime} ',
                        style: context.displayMedium.copyWith(
                          color: ColorManager.textGray,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                TweenAnimationBuilder<Duration>(
                    duration: Duration(
                        seconds: _examEntity.remainingExamTimeBySeconds),
                    tween: Tween(
                        begin: Duration(
                            seconds: _examEntity.remainingExamTimeBySeconds),
                        end: Duration.zero),
                    onEnd: () {
                      print('Timer ended');
                    },
                    builder:
                        (BuildContext context, Duration value, Widget? child) {
                      final minutes = value.inMinutes;
                      final seconds = value.inSeconds % 60;
                      return SizedBox(
                        height: 65.0,
                        width: 130.0,
                        child: Card(
                          color: minutes <= 2
                              ? Colors.redAccent.shade200
                              : ColorManager.secondary,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                              child: Text(
                                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                softWrap: true,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    _examEntity.examQuestions[_indexQuestion].examQuestionImage,
                    height: context.heightBody * 0.3,
                    width: context.width,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                height: context.height * 0.38,
                                width: context.width,
                                child: InteractiveImage(
                                  Image.network(
                                    _examEntity.examQuestions[_indexQuestion]
                                        .examQuestionImage,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        color: ColorManager.secondary,
                        elevation: 5.0,
                        shape: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.fullscreen,
                            size: 30.0,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class InteractiveImage extends StatefulWidget {
  InteractiveImage(this.image, {Key? key}) : super(key: key);

  final Image image;

  @override
  _InteractiveImageState createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  _InteractiveImageState();

  double _scale = 1.0;
  double _previousScale = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() => print("STATE SET\n"));
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        print(details);
        // Does this need to go into setState, too?
        // We are only saving the scale from before the zooming started
        // for later - this does not affect the rendering...
        _previousScale = _scale;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        print(details);
        setState(() => _scale = _previousScale * details.scale);
      },
      onScaleEnd: (ScaleEndDetails details) {
        print(details);
        // See comment above
        _previousScale = 0.0;
      },
      child: SizedBox(
        height: 200,
        child: Transform(
          transform: Matrix4.diagonal3(vector.Vector3(_scale, _scale, _scale)),
          alignment: FractionalOffset.center,
          child: widget.image,
        ),
      ),
    );
  }
}
