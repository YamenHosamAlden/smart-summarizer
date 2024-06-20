import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Bloc/summarizer_bloc/summarizer_bloc.dart';
import 'package:smartsummarizer/Bloc/text_to_speech_bloc/text_to_speech_bloc.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Util/functions.dart';
import 'package:smartsummarizer/Widgets/app_bar_widget.dart';
import 'package:smartsummarizer/Widgets/custom_button.dart';
import 'package:smartsummarizer/Widgets/custom_text.dart';
import 'package:smartsummarizer/Widgets/custom_text_falid.dart';
import 'package:smartsummarizer/Widgets/loading_widget.dart';

class SummarizerTextScreen extends StatefulWidget {
  const SummarizerTextScreen({super.key});

  @override
  State<SummarizerTextScreen> createState() => _SummarizerTextScreenState();
}

class _SummarizerTextScreenState extends State<SummarizerTextScreen> {
  final SummarizerBloc summarizerBloc = SummarizerBloc();
  final TextToSpeechBloc textToSpeechBloc = TextToSpeechBloc();
  final TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => summarizerBloc,
        ),
        BlocProvider(
          create: (context) => textToSpeechBloc..add(TextToSpeechInit()),
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: appBarWidget(context, title: "Summarizer Image")),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: CustomTextField(
                    controller: textController,
                    textInputType: TextInputType.text,
                    maxLine: 4,
                    hintText: "Add your text",
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "Please Enter Your Text";
                      }

                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: BlocConsumer<SummarizerBloc, SummarizerState>(
                    listener: (context, state) {
                      if (state is SummarizerTextErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar(
                          context,
                          message: state.message,
                        ));
                      }

                      if (state is SummarizerTextSuccessfulState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(successSnackBar(
                          context,
                          message: "Summarize successful",
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is SummarizerTextLoadingState) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }
                      return Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 2.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(5.w)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CustomText(
                                      textData: summarizerBloc
                                              .summarizeTextModel?.summary ??
                                          "Waiting for Summarize",
                                      textAlign: TextAlign.center,
                                      textColor: AppColors.primaryColor,
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    BlocBuilder<SummarizerBloc, SummarizerState>(
                      builder: (context, state) {
                        return summarizerBloc.summarizeTextModel?.summary !=
                                null
                            ? BlocConsumer<TextToSpeechBloc, TextToSpeechState>(
                                listener: (context, state) {
                                  if (state is TextErrorState) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(errorSnackBar(
                                      context,
                                      message: state.message,
                                    ));
                                  }
                                },
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton.small(
                                          onPressed: () {
                                            textToSpeechBloc
                                                .add(TextPauseEvent());
                                          },
                                          child: const Icon(
                                            Icons.pause,
                                            color: AppColors.whiteColor,
                                          )),
                                      FloatingActionButton.small(
                                          onPressed: () {
                                            textToSpeechBloc.add(SetTextEvent(
                                                textToSpeech: summarizerBloc
                                                    .summarizeTextModel!
                                                    .summary!));
                                          },
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: AppColors.whiteColor,
                                          )),
                                      FloatingActionButton.small(
                                          onPressed: () {
                                            textToSpeechBloc
                                                .add(TextStopEvent());
                                          },
                                          child: const Icon(
                                            Icons.stop,
                                            color: AppColors.whiteColor,
                                          )),
                                    ],
                                  );
                                },
                              )
                            : const SizedBox();
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                summarizerBloc.add(SummarizerTextEvent(
                                    text: textController.text));
                              }
                            },
                            buttonText: "Summarize"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
