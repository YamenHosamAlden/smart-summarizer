import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartsummarizer/Data/Models/summarize_model.dart';
import 'package:smartsummarizer/Data/Repository/summarizer_repository.dart';
import 'package:smartsummarizer/Services/Helper/api_result.dart';

part 'summarizer_event.dart';
part 'summarizer_state.dart';

class SummarizerBloc extends Bloc<SummarizerEvent, SummarizerState> {
  SummarizerRepository summarizerRepository = SummarizerRepository();
  SummarizeFileModel? summarizeImageModel;
    SummarizeFileModel? summarizePdfModel;
  SummarizeTextModel? summarizeTextModel;
  SummarizerBloc() : super(SummarizerInitial()) {
    on<SummarizerImageEvent>((event, emit) async {
      emit(SummarizerImageLoadingState());

      ApiResult apiResult = await summarizerRepository.summarizerImage(
          fileImage: event.fileImage);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        summarizeImageModel =
            SummarizeFileModel.fromJson(apiResult.response!.data);
        emit(SummarizerImageSuccessfulState());
      } else {
        emit(SummarizerImageErrorState(message: apiResult.error));
      }
    });


       on<SummarizerPdfEvent>((event, emit) async {
      emit(SummarizerPdfLoadingState());

      ApiResult apiResult = await summarizerRepository.summarizerPdf(
          filePdf: event.filePdf);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        summarizePdfModel =
            SummarizeFileModel.fromJson(apiResult.response!.data);
        emit(SummarizerPdfSuccessfulState());
      } else {
        emit(SummarizerPdfErrorState(message: apiResult.error));
      }
    });


     on<SummarizerTextEvent>((event, emit) async {
      emit(SummarizerTextLoadingState());

      ApiResult apiResult = await summarizerRepository.summarizerText(
          text: event.text);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        summarizeTextModel =
            SummarizeTextModel.fromJson(apiResult.response!.data);
        emit(SummarizerTextSuccessfulState());
      } else {
        emit(SummarizerTextErrorState(message: apiResult.error));
      }
    });
  }
}
