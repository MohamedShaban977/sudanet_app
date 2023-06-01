import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/course_details_entity.dart';
import '../../domain/use_cases/course_details_use_case.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit({required this.coursesUseCases})
      : super(CourseDetailsInitial());
  final CoursesUseCases coursesUseCases;

  static CourseDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getCourseDetails(String id) async {
    emit(GetCourseDetailsLoadingState());
    Either<Failure, BaseResponseEntity<CourseDetailsEntity>> response =
        await coursesUseCases.call(id);
    response.fold(
      (failure) => emit(GetCourseDetailsErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetCourseDetailsSuccessState(response: response)),
    );
  }
}
