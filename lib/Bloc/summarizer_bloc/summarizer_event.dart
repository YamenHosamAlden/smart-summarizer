// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'summarizer_bloc.dart';

@immutable
sealed class SummarizerEvent {}

class SummarizerImageEvent extends SummarizerEvent {
  final File fileImage;
  SummarizerImageEvent({
    required this.fileImage,
  });
}
class SummarizerPdfEvent extends SummarizerEvent {
  final File filePdf;
  SummarizerPdfEvent({
    required this.filePdf,
  });
}


class SummarizerTextEvent extends SummarizerEvent {
  final String text;
  SummarizerTextEvent({
    required this.text,
  });
}
