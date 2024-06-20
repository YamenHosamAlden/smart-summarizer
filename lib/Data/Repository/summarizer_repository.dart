import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartsummarizer/Services/Helper/api_result.dart';
import 'package:smartsummarizer/Services/Helper/error_api_handler.dart';
import 'package:smartsummarizer/Services/Network/dio_api_service.dart';
import 'package:smartsummarizer/Services/Network/urls_api.dart';

class SummarizerRepository {
  DioApiService dioApiService = DioApiService();

  Future<ApiResult> summarizerImage({required File fileImage}) async {
    String fileName = fileImage.path.split('/').last;
    FormData summarizerMapFormData = FormData.fromMap({
      "file": await MultipartFile.fromFile(fileImage.path, filename: fileName),
    });

    try {
      Response response = await dioApiService
          .postData(UrlsApi.summarizerImageApi, data: summarizerMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }


  Future<ApiResult> summarizerPdf({required File filePdf}) async {
    String fileName = filePdf.path.split('/').last;
    FormData summarizerMapFormData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePdf.path, filename: fileName),
    });

    try {
      Response response = await dioApiService
          .postData(UrlsApi.summarizerPdfApi, data: summarizerMapFormData);
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }

  Future<ApiResult> summarizerText({required String text}) async {
    try {
      Response response = await dioApiService
          .postData(UrlsApi.summarizerTextApi, data: {'text': text});
      return ApiResult.withSuccess(response);
    } catch (error) {
      return ApiResult.withError(ErrorApiHandler.getErrorMessage(error));
    }
  }
}
