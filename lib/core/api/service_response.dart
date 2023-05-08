import 'package:equatable/equatable.dart';
import 'package:sudanet_app/core/app_manage/extension_manager.dart';

/// Base Service Response
class BaseResponseEntity<T> extends Equatable {
  final String message;
  final bool success;
  final T? data;

  const BaseResponseEntity(
      {required this.message, required this.success, required this.data});

  @override
  List<Object?> get props => [success, message, data];
}

class BaseResponse<T> extends BaseResponseEntity<T> {
  const BaseResponse({
    required bool success,
    required String message,
    required T? data,
  }) : super(success: success, message: message, data: data);

  factory BaseResponse.fromJson(Map<String, dynamic> json,
      [Function(Map<String, dynamic> data)? build]) {
    return BaseResponse<T>(
      success: json["success"],
      message: json["message"] ?? '',
      data: json["data"] != null
          ? build == null
              ? json["data"]
              : build(json["data"])
          : null,
    );
  }
}

/// Base Response collection
/*class CollectionResponseEntity<T> extends Equatable {
  final String message;
  final bool success;
  final List<T>? data;

  const CollectionResponseEntity(
      {required this.message, required this.success, required this.data});

  @override
  List<Object?> get props => [success, message, data];
}

class CollectionResponse<T> extends CollectionResponseEntity<T> {
  const CollectionResponse({
    required bool success,
    required String message,
    required List<T>? data,
  }) : super(success: success, message: message, data: data);

  factory CollectionResponse.fromJson(Map<String, dynamic> json,
      [Function(List<dynamic> list)? build]) {
    return CollectionResponse<T>(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? build == null
              ? json["data"]
              : build(json["data"])
          : [],
    );
  }
}*/



class CollectionResponseEntity<T> extends Equatable {
  final int count;
  final dynamic next;
  final dynamic previous;
  final List<T> results;

  const CollectionResponseEntity(
      {required this.count,required this.next,required this.previous,required this.results, });

  @override
  List<Object?> get props => [count,next,previous,results];
}

class CollectionResponse<T> extends CollectionResponseEntity<T> {
   CollectionResponse({
    required int? count,
    required dynamic next,
    required dynamic previous,
    required List<T>? results,
  }) : super(count:count.orZero(), next: next,previous: previous, results:  results.orEmptyList());

  factory CollectionResponse.fromJson(Map<String, dynamic> json, [Function(List<dynamic> list)? build]) {
    return CollectionResponse<T>(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] != null
          ? build == null
          ? json["results"]
          : build(json["results"])
          : [],
    );


  }
   Map<String, dynamic> toJson() => {
     "count": count,
     "next": next,
     "previous": previous,
     "results": results,
   };


}


