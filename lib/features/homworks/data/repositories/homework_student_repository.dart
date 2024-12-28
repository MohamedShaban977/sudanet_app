import 'package:dartz/dartz.dart';
import 'package:sudanet_app/core/api/service_response.dart';
import 'package:sudanet_app/core/error/exceptions.dart';
import 'package:sudanet_app/core/error/failures.dart';
import 'package:sudanet_app/features/homworks/data/data_sources/homework_student_data_source.dart';
import 'package:sudanet_app/features/homworks/data/models/homework_item_model.dart';

abstract class HomeworksStudentRepository {
  Future<Either<Failure, CollectionResponse<HomeworkItemModel>>> getHomeworkBySubject(String subjectId);
}

class HomeworksStudentRepositoryImpl extends HomeworksStudentRepository {
  final HomeworksStudentDataSource dataSource;

  HomeworksStudentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponse<HomeworkItemModel>>> getHomeworkBySubject(String subjectId) async {
    try {
      final res = await dataSource.getHomeworkBySubject(subjectId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
