import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_tts/flutter_tts.dart';

part 'text_to_speech_event.dart';
part 'text_to_speech_state.dart';

class TextToSpeechBloc extends Bloc<TextToSpeechEvent, TextToSpeechState> {
  late FlutterTts flutterTts;
  String language = "en-US";
  String engine = "com.google.android.tts";
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.5;
  String? newVoiceText;
  TextToSpeechBloc() : super(TextToSpeechInitial()) {
    on<TextToSpeechInit>((event, emit) async {
      flutterTts = FlutterTts();

      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage(language);

      flutterTts.setStartHandler(() {
        emit(TextStartState());
      });

      flutterTts.setCompletionHandler(() {
        emit(TextStopState());
      });

      flutterTts.setCancelHandler(() {
        emit(TextStopState());
      });

      flutterTts.setPauseHandler(() {
        emit(TextPauseState());
      });

      flutterTts.setContinueHandler(() {
        emit(TextStartState());
      });

      flutterTts.setErrorHandler((msg) {
        emit(TextErrorState(message: msg));
      });
    });

    on<SetTextEvent>((event, emit) async {
      String text = event.textToSpeech;
      newVoiceText = text;
      add(TextSpeakEvent());
    });

    on<TextSpeakEvent>((event, emit) async {
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setPitch(pitch);

      if (newVoiceText != null) {
        if (newVoiceText!.isNotEmpty) {
          await flutterTts.speak(newVoiceText!);
          emit(TextStartState());
        }
      }
    });

    on<TextPauseEvent>((event, emit) async {
      var result = await flutterTts.pause();
      if (result == 1) {
        emit(TextPauseState());
      }
    });

    on<TextStopEvent>((event, emit) async {
      var result = await flutterTts.stop();
      if (result == 1) {
        emit(TextStopState());
      }
    });
  }
}
