import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sudanet_app/core/api/status_code.dart';
import 'package:sudanet_app/features/auth/login/presentation/manger/user_secure_storage.dart';
import 'package:sudanet_app/widgets/toast_and_snackbar.dart';

import '../../app/injection_container.dart';
import '../app_manage/contents_manager.dart';
import '../cache/cache_data_shpref.dart';

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

    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers[HttpHeaders.contentTypeHeader] =
        options.data.runtimeType == FormData
            ? Headers.multipartFormDataContentType
            : Headers.jsonContentType;

    options.headers[HttpHeaders.acceptLanguageHeader] =
        sl<CacheHelper>().getData(key: Constants.locale);

    if (UserSecureStorage.getToken() != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${UserSecureStorage.getToken()}';
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
    // options.headers = {
    //   "Content-Type": options.data.runtimeType == FormData
    //       ? 'multipart/form-data'
    //       : "application/json",
    // };
    // }

    /// => Headers
    debugPrint('REQUEST[${options.method}] => Headers: ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    log('RESPONSE[${response.statusCode}] => data: ${response.data}');

    if (response.statusCode == StatusCode.badRequest) {
      var error = jsonDecode(response.data);

      // ToastAndSnackBar.toastError(message: error['title']);
      ToastAndSnackBar.showSnackBarFailure(
          title: response.statusMessage!, message: error['title']!);
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('ERROR[${err.type}] => Error: ${err.error}');

    if (err.type == DioErrorType.unknown) {
      // MagicRouterName.navigateTo(RoutesNames.loginRoute);
      ToastAndSnackBar.showSnackBarFailure(
          title: 'ERROR ${err.type.name}', message: err.message!);
    }

    return super.onError(err, handler);
  }
}
