part of 'text_to_speech_bloc.dart';

@immutable
sealed class TextToSpeechEvent {}

class TextToSpeechInit extends TextToSpeechEvent {}

class SetTextEvent extends TextToSpeechEvent {
  final String textToSpeech;

  SetTextEvent({required this.textToSpeech});
}

class TextSpeakEvent extends TextToSpeechEvent {}

class TextStopEvent extends TextToSpeechEvent {}

class TextPauseEvent extends TextToSpeechEvent {}
