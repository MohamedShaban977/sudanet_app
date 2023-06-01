part of 'course_details_cubit.dart';

abstract class CourseDetailsState extends Equatable {
  @override
  List<Object> get props => [];

  const CourseDetailsState();
}

class CourseDetailsInitial extends CourseDetailsState {}

class GetCourseDetailsLoadingState extends CourseDetailsState {}

class GetCourseDetailsSuccessState extends CourseDetailsState {
  final BaseResponseEntity<CourseDetailsEntity> response;

  const GetCourseDetailsSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class GetCourseDetailsErrorState extends CourseDetailsState {
  final String error;

  const GetCourseDetailsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
