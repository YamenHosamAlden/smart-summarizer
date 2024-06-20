import 'package:dio/dio.dart';

class ErrorApiHandler {
  static String getErrorMessage(dynamic error) {
    String? errorDescription;
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;

            case DioExceptionType.connectionError:
              errorDescription = "No internet";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                case 400:
                  errorDescription = "${error.response!.data['message']}";
                  break;
                default:
                  errorDescription = error.response!.statusMessage;

                // "Failed to load data - status code: ${error.response!.statusCode} \n The error is : ${error.response!.data['error']}";
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;

            default:
              errorDescription = "is not a subtype of Dio Exception Type";
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (error) {
        errorDescription = error.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription!;
  }
}
