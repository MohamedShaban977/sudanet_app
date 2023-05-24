import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// => PATH
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    /// => QUERY
    debugPrint(
        'REQUEST[${options.method}] => QUERY: ${options.queryParameters}');

    /// => BODY
    if (options.data.runtimeType == FormData) {
      // var form = FormData.fromMap({});
      // // form.;
      debugPrint(
          'REQUEST[${options.method}] => Request Data: ${options.data.fields}');

      if (options.data?.files != [] && options.data?.files?.length != 0) {
        debugPrint(
            'REQUEST[${options.method}] => MultipartFile: ${options.data?.files?.single.value.filename}');
        debugPrint(
            'REQUEST[${options.method}] => MultipartFile: ${options.data?.files?.single.value.isFinalized}');
      }
    } else {
      debugPrint('REQUEST[${options.method}] => Request Data: ${options.data}');
    }

    // if (sl<CacheHelper>().getToken() != null) {
    //   options.headers = {
    //     "Content-Type": options.data.runtimeType == FormData
    //         ? 'multipart/form-data'
    //         : "application/json",
    //     'Accept': '*/*',
    //     'Authorization': 'Bearer ${sl<CacheHelper>().getToken()}',
    //   };
    // } else {
    options.headers = {
      "Content-Type": options.data.runtimeType == FormData
          ? 'multipart/form-data'
          : "application/json",
    };
    // }

    /// => Headers
    debugPrint('REQUEST[${options.method}] => Headers: ${options.headers}');

    super.onRequest(options, handler);
    // print(' handler.isCompleted ${handler.isCompleted}');
    // if (options.data.runtimeType == FormData && handler.isCompleted) {
    //   print(' handler.isCompleted ${options.data.runtimeType}');
    //   options.data = FormData();
    // }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    debugPrint('RESPONSE[${response.statusCode}] => data: ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('ERROR[${err.type}] => Error: ${err.error}');

    return super.onError(err, handler);
  }
}
