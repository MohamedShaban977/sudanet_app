import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app/core/app_manage/assets_manager.dart';
import 'package:sudanet_app/core/app_manage/color_manager.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';
import 'package:sudanet_app/core/app_manage/strings_manager.dart';
import 'package:sudanet_app/core/locale/app_localizations.dart';
import 'package:sudanet_app/features/exam/presentation/cubit/exam_cubit.dart';
import 'package:sudanet_app/widgets/custom_button_with_loading.dart';

import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../domain/entities/exam_ready_entity.dart';

class ExamLayoutScreen extends StatefulWidget {
  final String id;

  const ExamLayoutScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ExamLayoutScreen> createState() => _ExamLayoutScreenState();
}

class _ExamLayoutScreenState extends State<ExamLayoutScreen> {
  late ExamReadyEntity examReadyEntity = const ExamReadyEntity(
    id: 0,
    examName: '',
    questionsCount: 0,
    examTime: '',
    remainingExamTime: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (context, state) {
        if (state is GetExamReadySuccessState) {
          examReadyEntity = state.response.data!;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ModalProgressHUD(
            inAsyncCall: state is GetExamReadyLoadingState,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset(SvgAssets.exam,
                      height: context.heightBody * 0.35),
                  const SizedBox(height: 20.0),
                  Text(examReadyEntity.examName,
                      style: context.bodyLarge.copyWith(
                        color: ColorManager.primary,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  Text(
                      '${AppStrings.examDuration.tr()} \t ${examReadyEntity.examTime}',
                      style: context.displayMedium.copyWith(
                        color: ColorManager.textGray,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  Text(
                      '${AppStrings.remainingTime.tr()} \t ${examReadyEntity.remainingExamTime}',
                      style: context.displayMedium.copyWith(
                        color: ColorManager.textGray,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  Text(
                      '${AppStrings.questionsCount.tr()} \t ${examReadyEntity.questionsCount}',
                      style: context.displayMedium.copyWith(
                        color: ColorManager.textGray,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CustomButtonWithLoading(
                          text: AppStrings.examStart.tr(),
                          borderRadius: 5.0,
                          height: 50.0,
                          width: context.width,
                          color: ColorManager.secondary,
                          textColors: ColorManager.primary,
                          onTap: () async {
                            MagicRouterName.navigateTo(
                              RoutesNames.examRoute,
                              arguments: {'id': '${examReadyEntity.id}'},
                            );
                          }),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
