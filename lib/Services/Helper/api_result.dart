import 'package:dio/dio.dart';

class ApiResult {
  final Response? response;
  final dynamic error;

  ApiResult(this.response, this.error);

  ApiResult.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResult.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
