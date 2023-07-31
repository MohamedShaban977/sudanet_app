import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/features/exam/data/models/save_answer_request.dart';
import 'package:sudanet_app/features/exam/domain/entities/exam_entity.dart';
import 'package:sudanet_app/features/exam/domain/entities/exam_ready_entity.dart';
import 'package:sudanet_app/features/exam/domain/use_cases/exam_use_case.dart';

import '../../../../core/error/failures.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit({
    required this.getExamReadyUseCases,
    required this.endExamUseCases,
    required this.getExamQuestionOrPercentageUseCases,
    required this.saveAnswerUseCases,
  }) : super(ExamInitial());
  final GetExamReadyUseCases getExamReadyUseCases;
  final GetExamQuestionOrPercentageUseCases getExamQuestionOrPercentageUseCases;
  final SaveAnswerUseCases saveAnswerUseCases;
  final EndExamUseCases endExamUseCases;

  ExamCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getExamReady(String id) async {
    emit(GetExamReadyLoadingState());
    Either<Failure, BaseResponseEntity<ExamReadyEntity>> response =
        await getExamReadyUseCases.call(id);
    response.fold(
        (failure) => emit(
              GetExamReadyErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(GetExamReadySuccessState(response)));
  }

  Future<void> getExamQuestionOrPercentage(String id) async {
    emit(GetExamQuestionOrPercentageLoadingState());
    Either<Failure, BaseResponseEntity<ExamEntity>> response =
        await getExamQuestionOrPercentageUseCases.call(id);
    response.fold(
        (failure) => emit(
              GetExamQuestionOrPercentageErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(GetExamQuestionOrPercentageSuccessState(response)));
  }

  Future<void> saveAnswer(SaveAnswerRequest request) async {
    emit(SaveAnswerLoadingState());
    Either<Failure, BaseResponseEntity<bool>> response =
        await saveAnswerUseCases.call(request);
    response.fold(
        (failure) => emit(
              SaveAnswerErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(SaveAnswerSuccessState(response)));
  }

  Future<void> endExam(String studentExamId) async {
    emit(EndExamLoadingState());
    Either<Failure, BaseResponseEntity<dynamic>> response =
        await endExamUseCases.call(studentExamId);
    response.fold(
        (failure) => emit(
              EndExamErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(EndExamSuccessState(response)));
  }
}
