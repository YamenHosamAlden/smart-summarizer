part of 'text_to_speech_bloc.dart';

@immutable
sealed class TextToSpeechState {}

final class TextToSpeechInitial extends TextToSpeechState {}

final class TextStopState extends TextToSpeechState {}

final class TextPauseState extends TextToSpeechState {}

final class TextStartState extends TextToSpeechState {}

final class TextErrorState extends TextToSpeechState {
  final String message;

  TextErrorState({required this.message});
  
}
