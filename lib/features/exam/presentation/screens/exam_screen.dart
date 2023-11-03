import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sudanet_app/app/injection_container.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/exam/domain/entities/exam_entity.dart';
import 'package:sudanet_app/widgets/custom_button_with_loading.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/packages/quickalert/quickalert.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_error_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/toast_and_snackbar.dart';
import '../../data/models/save_answer_request.dart';
import '../cubit/exam_cubit.dart';

enum AnswersQuestions {
  one(1),
  two(2),
  three(3),
  four(4);

  const AnswersQuestions(this.value);

  final int value;
}

class ExamScreen extends StatefulWidget {
  // final ExamEntity examEntity;
  final String id;

  const ExamScreen({Key? key, /*required this.examEntity,*/ required this.id})
      : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  bool _isInForeground = true;

  late ExamEntity _examEntity;

  int _indexQuestion = 0;
  AnswersQuestions? _answerQuestion;

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
    // _examEntity = widget.examEntity;
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
      listener: _initListener,
      builder: (context, state) {
        if (state is GetExamQuestionOrPercentageErrorState) {
          return const Scaffold(body: CustomErrorWidget());
        }
        if (state is GetExamQuestionOrPercentageLoadingState) {
          return const CustomLoadingScreen();
        }
        return Scaffold(
          appBar: CustomAppBarExam(examEntity: _examEntity),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    NewLineStep(isActive: true, isFirst: true),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: false),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: false),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: false),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: false),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: false),
                    NewLineStep(isActive: true),
                    NewLineStep(isActive: true, isLast: true),
                    const SizedBox(width: 10),
                  ],
                ),
              ),

              ///  question image
              ImageQuestionWidget(
                examQuestionImage:
                    _examEntity.examQuestions[_indexQuestion].examQuestionImage,
              ),
              const SizedBox(height: 15.0),

              /// answers button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnswerButtonWidget(
                      onPressed: () {
                        setState(() {
                          _answerQuestion = AnswersQuestions.one;
                        });
                      },
                      isSelectedAnswer:
                          _isCheckedSelectedAnswer(AnswersQuestions.one),
                      text: AppStrings.firstAnswer.tr(),
                    ),
                    const SizedBox(height: 15.0),
                    AnswerButtonWidget(
                      onPressed: () {
                        setState(() {
                          _answerQuestion = AnswersQuestions.two;
                        });
                      },
                      isSelectedAnswer:
                          _isCheckedSelectedAnswer(AnswersQuestions.two),
                      text: AppStrings.secondAnswer.tr(),
                    ),
                    const SizedBox(height: 15.0),
                    AnswerButtonWidget(
                      onPressed: () {
                        setState(() {
                          _answerQuestion = AnswersQuestions.three;
                        });
                      },
                      isSelectedAnswer:
                          _isCheckedSelectedAnswer(AnswersQuestions.three),
                      text: AppStrings.thirdAnswer.tr(),
                    ),
                    const SizedBox(height: 15.0),
                    AnswerButtonWidget(
                      onPressed: () {
                        setState(() {
                          if (_answerQuestion == AnswersQuestions.four) {
                            _answerQuestion = null;
                          } else {
                            _answerQuestion = AnswersQuestions.four;
                          }
                        });
                      },
                      isSelectedAnswer:
                          _isCheckedSelectedAnswer(AnswersQuestions.four),
                      text: AppStrings.fourthAnswer.tr(),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 15.0),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: (_indexQuestion > 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_indexQuestion > 0) {
                            setState(() {
                              _indexQuestion -= 1;
                              _answerQuestion = null;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(context.width * 0.35, 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Text(AppStrings.previous.tr()),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.35,
                      child: Visibility(
                        visible:
                            _indexQuestion == _examEntity.questionsCount - 1,

                        /// next Question
                        replacement: Center(
                          child: CustomButtonWithLoading(
                            onTap: () async {
                              await sl<ExamCubit>()
                                  .get(context)
                                  .saveAnswer(SaveAnswerRequest(
                                    answer: _answerIdSubmit(),
                                    examQuestionId: _examEntity
                                        .examQuestions[_indexQuestion]
                                        .examQuestionId,
                                  ));
                            },
                            height: 50.0,
                            width: context.width * 0.35,
                            text: AppStrings.next.tr(),
                          ),
                        ),

                        ///  finishing exam
                        child: CustomButtonWithLoading(
                          onTap: () async {
                            await sl<ExamCubit>()
                                .get(context)
                                .saveAnswer(SaveAnswerRequest(
                                  answer: _answerIdSubmit(),
                                  examQuestionId: _examEntity
                                      .examQuestions[_indexQuestion]
                                      .examQuestionId,
                                ));
                          },
                          height: 50.0,
                          width: context.width * 0.35,
                          text: AppStrings.finishExam.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        );
      },
    );
  }

  void _initListener(context, state) async {
    if (state is GetExamQuestionOrPercentageSuccessState) {
      _examEntity = state.response.data!;

      if (_examEntity.percentage != null) {
        MagicRouter.pop();

        QuickAlert.show(
          context: MagicRouter.currentContext!,
          type: QuickAlertType.success,
          title:
              '${AppStrings.examResult.tr()}\t ${state.response.data!.examName}',
          text:
              '${AppStrings.appreciation.tr()}: ${AppStrings.successful.tr()}\n\n , ${AppStrings.successRate.tr()}: ${state.response.data!.percentage}',
          borderRadius: AppSize.s8,
          widget: Column(children: [
            ElevatedButton(
                onPressed: () => MagicRouter.pop(),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: ColorManager.primary,
                  foregroundColor: ColorManager.white,
                ),
                child: Text(AppStrings.cancel.tr()))
          ]),
        ).then((value) => MagicRouter.pop());
      }
      for (int i = 0; i < _examEntity.examQuestions.length; i++) {
        if (_examEntity.examQuestions[i].binHere) {
          _indexQuestion = i + 1;
          print('[i] ==> ${_examEntity.examQuestions[i].binHere}');
          print('[i].binHere ==> $i');
          return;
        }
      }
    }

    if (state is SaveAnswerSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);

      _examEntity.examQuestions[_indexQuestion].examQuestionAnswer =
          _answerQuestion?.value ??
              _examEntity.examQuestions[_indexQuestion].examQuestionAnswer;
      if (_indexQuestion < _examEntity.questionsCount - 1) {
        _indexQuestion += 1;
        _answerQuestion = null;
      } else if (_indexQuestion == _examEntity.questionsCount - 1) {
        _showAlertConfirmEndedExam(context);
      }
    }
    if (state is SaveAnswerErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
    if (state is EndExamSuccessState) {
      ToastAndSnackBar.showSnackBarWarning(
        context,
        title: AppStrings.endedExamTitle.tr(),
        message: AppStrings.endedExamMassage.tr(),
        durationMilliseconds: 5000,
      );
      await Future.delayed(const Duration(milliseconds: 6000), () {
        if (state.response.data!.isFail) {
          ToastAndSnackBar.showSnackBarFailure(
            context,
            title:
                '${AppStrings.examResult.tr()}\t ${state.response.data!.examName}',
            message:
                '${AppStrings.appreciation.tr()} : ${AppStrings.fail.tr()} \t , ${AppStrings.successRate.tr()}: ${state.response.data!.percentage}',
            // durationMilliseconds: 800,
          );
        } else {
          ToastAndSnackBar.showSnackBarSuccess(
            context,
            title:
                '${AppStrings.examResult.tr()}\t ${state.response.data!.examName}',
            message:
                '${AppStrings.appreciation.tr()}: ${AppStrings.successful.tr()}\t , ${AppStrings.successRate.tr()}: ${state.response.data!.percentage}',
            // durationMilliseconds: 800,
          );
        }
      });

      MagicRouterName.navigateAndPopUntilFirstPage(
        RoutesNames.examLayoutRoute,
        arguments: {'id': widget.id},
      );
    }
  }

  void _showAlertConfirmEndedExam(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: AppStrings.examCompleted.tr(),
      text: AppStrings.reviewYourAnswersBeforeFinishing.tr(),
      borderRadius: AppSize.s8,
      widget: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ElevatedButton(
            onPressed: () {
              MagicRouter.pop();
              setState(() {
                _indexQuestion = 0;
              });
            },
            child: Text(AppStrings.reviewAnswers.tr())),
        ElevatedButton(
            onPressed: () {
              sl<ExamCubit>()
                  .get(context)
                  .endExam('${_examEntity.studentExamId}');
              MagicRouter.pop();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
            ),
            child: Text(AppStrings.ending.tr()))
      ]),
    );
  }

  int _answerIdSubmit() {
    if (_answerQuestion != null) {
      return _answerQuestion!.value;
    } else if (_examEntity.examQuestions[_indexQuestion].examQuestionAnswer !=
        null) {
      return _examEntity.examQuestions[_indexQuestion].examQuestionAnswer!;
    } else {
      return 0;
    }
    // return _answerQuestion?.value ??
    //                           _examEntity.examQuestions[_indexQuestion]
    //                               .examQuestionAnswer!;
  }

  bool _isCheckedSelectedAnswer(AnswersQuestions answer) {
    // if (_answerQuestion != null) {
    //   return _answerQuestion == answer ? true : false;
    // } else if (_examEntity.examQuestions[_indexQuestion].examQuestionAnswer !=
    //     null) {
    //   return _examEntity.examQuestions[_indexQuestion].examQuestionAnswer ==
    //           answer.value
    //       ? true
    //       : false;
    // } else {
    //   return false;
    // }
    return _answerQuestion != null
        ? _answerQuestion == answer
            ? true
            : false
        : _examEntity.examQuestions[_indexQuestion].examQuestionAnswer != null
            ? _examEntity.examQuestions[_indexQuestion].examQuestionAnswer ==
                    answer.value
                ? true
                : false
            : false;
  }
}

class CustomAppBarExam extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarExam({
    super.key,
    required ExamEntity examEntity,
  }) : _examEntity = examEntity;

  final ExamEntity _examEntity;
  static const double _toolbarHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _toolbarHeight,
      elevation: 0.5,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_examEntity.examName,
                  style: context.bodyLarge
                      .copyWith(color: ColorManager.primary, fontSize: 22.0),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10.0),
              Text('${AppStrings.examDuration.tr()} ${_examEntity.examTime} ',
                  style: context.displayMedium.copyWith(
                    color: ColorManager.textGray,
                  ),
                  textAlign: TextAlign.center),
            ],
          ),
          TweenAnimationBuilder<Duration>(
              duration: Duration(
                milliseconds:
                    (_examEntity.remainingExamTimeBySeconds * 1000 - 5000)
                        .toInt(),
              ),
              tween: Tween(
                  begin: Duration(
                    milliseconds:
                        (_examEntity.remainingExamTimeBySeconds * 1000 - 5000)
                            .toInt(),
                  ),
                  end: Duration.zero),
              onEnd: () async {
                debugPrint('Timer ended');
                await ToastAndSnackBar.showSnackBarWarning(
                  context,
                  title: '',
                  message: AppStrings.examTimeIsUp.tr(),
                  durationMilliseconds: 5000,
                );
                await Future.delayed(const Duration(milliseconds: 5000), () {
                  sl<ExamCubit>()
                      .get(context)
                      .endExam('${_examEntity.studentExamId}');
                });
              },
              builder: (BuildContext context, Duration value, Widget? child) {
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

// void _showAlertEndedTimeExam(BuildContext context) {
//   QuickAlert.show(
//     context: context,
//     type: QuickAlertType.warning,
//     title: AppStrings.examCompleted.tr(),
//     text: AppStrings.reviewYourAnswersBeforeFinishing.tr(),
//     borderRadius: AppSize.s8,
//     widget: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       ElevatedButton(
//           onPressed: () {
//             MagicRouter.pop();
//             setState(() {
//               _indexQuestion = 0;
//             });
//             MagicRouter.pop();
//           },
//           child: Text(AppStrings.reviewAnswers.tr())),
//       ElevatedButton(
//           onPressed: () {
//             sl<ExamCubit>()
//                 .get(context)
//                 .endExam('${_examEntity.studentExamId}');
//             MagicRouter.pop();
//           },
//           style: ElevatedButton.styleFrom(
//             elevation: 0.0,
//             backgroundColor: ColorManager.white,
//             foregroundColor: ColorManager.primary,
//           ),
//           child: Text(AppStrings.ending.tr()))
//     ]),
//   );
// }
}

class ImageQuestionWidget extends StatelessWidget {
  const ImageQuestionWidget({
    super.key,
    required this.examQuestionImage,
  });

  final String examQuestionImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: context.heightBody * 0.4,
          width: context.width,
          child: ClipRect(
            child: Hero(
              tag: "someTag",
              child: PhotoView(
                imageProvider: NetworkImage(examQuestionImage),
                gaplessPlayback: true,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                initialScale: PhotoViewComputedScale.covered,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroPhotoViewRouteWrapper(
                      imageProvider: NetworkImage(examQuestionImage),
                    ),
                  ),
                );
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Dialog(
                //       child: Container(
                //         // margin: const EdgeInsets.symmetric(
                //         //   vertical: 20.0,
                //         //   horizontal: 20.0,
                //         // ),
                //         height: context.heightBody * 0.6,
                //         width: context.width,
                //         child: ClipRect(
                //           child: PhotoView(
                //             imageProvider: NetworkImage(
                //               _examEntity
                //                   .examQuestions[_indexQuestion]
                //                   .examQuestionImage,
                //             ),
                //             maxScale:
                //                 PhotoViewComputedScale.covered * 2.0,
                //             minScale:
                //                 PhotoViewComputedScale.contained,
                //             initialScale:
                //                 PhotoViewComputedScale.covered,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
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
    );
  }
}

class NewLineStep extends StatelessWidget {
  const NewLineStep({
    Key? key,
    this.isActive = false,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  final bool isActive;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: isFirst
              ? const BorderRadiusDirectional.horizontal(
                  start: Radius.circular(100.0))
              : isLast
                  ? const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(100.0))
                  : BorderRadius.circular(0.0),
          color: isActive ? ColorManager.primary : Colors.grey[300],
        ),
      ),
      // child: Container(
      //   height: 10.0,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //   ),
      //   child: Divider(
      //     height: 10.0,
      //     color: isActive ? ColorManager.primary : Colors.grey[300],
      //     thickness: 8,
      //   ),
      // ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.red,
      ),
    );
  }
}

class AnswerButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelectedAnswer;

  final String text;

  const AnswerButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.isSelectedAnswer,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(50.0),
        backgroundColor:
            isSelectedAnswer ? ColorManager.secondary_2 : ColorManager.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: ColorManager.primary,
              width: 1.5,
            )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: context.labelLarge.copyWith(
                color: ColorManager.primary, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (isSelectedAnswer)
            Icon(
              Icons.check_circle_sharp,
              color: Colors.green[700],
              size: 30.0,
            )
        ],
      ),
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  const HeroPhotoViewRouteWrapper(
      {super.key,
      required this.imageProvider,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
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
