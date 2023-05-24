import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'courses_by_category_state.dart';

class CoursesByCategoryCubit extends Cubit<CoursesByCategoryState> {
  CoursesByCategoryCubit() : super(CoursesByCategoryInitial());
}
