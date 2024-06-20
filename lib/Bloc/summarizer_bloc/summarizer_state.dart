part of 'summarizer_bloc.dart';

@immutable
sealed class SummarizerState {}

final class SummarizerInitial extends SummarizerState {}
  final class SummarizerImageLoadingState extends SummarizerState {}

final class SummarizerImageSuccessfulState extends SummarizerState {}

final class SummarizerImageErrorState extends SummarizerState {
  final String message;

  SummarizerImageErrorState({required this.message});
}


  final class SummarizerTextLoadingState extends SummarizerState {}

final class SummarizerTextSuccessfulState extends SummarizerState {}

final class SummarizerTextErrorState extends SummarizerState {
  final String message;

  SummarizerTextErrorState({required this.message});
}


  final class SummarizerPdfLoadingState extends SummarizerState {}

final class SummarizerPdfSuccessfulState extends SummarizerState {}

final class SummarizerPdfErrorState extends SummarizerState {
  final String message;

  SummarizerPdfErrorState({required this.message});
}