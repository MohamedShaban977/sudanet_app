import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/categories_response.dart';
import '../models/courses_response.dart';

abstract class HomeDataSource {
  Future<CollectionResponse> getSliders();

  Future<CollectionResponse<CoursesResponse>> getCoursesDataSource();

  Future<CollectionResponse<CategoriesResponse>> getCategoriesDataSource();
}

class HomeDataSourceImpl implements HomeDataSource {
  ApiConsumer apiConsumer;

  HomeDataSourceImpl({required this.apiConsumer});

  @override
  Future<CollectionResponse<CategoriesResponse>>
      getCategoriesDataSource() async {
    final response = await apiConsumer.get(EndPoint.getCategories);

    final res = CollectionResponse<CategoriesResponse>.fromJson(response,
        (list) => list.map((e) => CategoriesResponse.fromJson(e)).toList());

    return res;
  }

  @override
  Future<CollectionResponse<CoursesResponse>> getCoursesDataSource() async {
    final response = await apiConsumer.get(EndPoint.getCategories);

    final res = CollectionResponse<CoursesResponse>.fromJson(response,
        (list) => list.map((e) => CoursesResponse.fromJson(e)).toList());

    return res;
  }

  @override
  Future<CollectionResponse> getSliders() async {
    final response = await apiConsumer.get(EndPoint.getSliders);

    final res = CollectionResponse.fromJson(response);

    return res;
  }
}
