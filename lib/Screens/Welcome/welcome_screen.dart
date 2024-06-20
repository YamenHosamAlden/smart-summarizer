import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_assets.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Screens/Summarizer/summarizer_image_screen.dart';
import 'package:smartsummarizer/Screens/Summarizer/summarizer_pdf_screen.dart';
import 'package:smartsummarizer/Screens/Summarizer/summarizer_text_screen.dart';
import 'package:smartsummarizer/Util/GeneralRoute.dart';
import 'package:smartsummarizer/Widgets/app_bar_widget.dart';
import 'package:smartsummarizer/Widgets/custom_button.dart';
import 'package:smartsummarizer/Widgets/custom_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<ButtonContent> buttons = [
    ButtonContent(
        text: "Text Summarizer",
        iconImage: AppAssets.textIcon,
        selected: false),
    ButtonContent(
        text: "Pdf Summarizer", iconImage: AppAssets.pdfIcon, selected: false),
    ButtonContent(
        text: "Photo Summarizer",
        iconImage: AppAssets.photoIcon,
        selected: false),
  ];

  int? activeIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: appBarWidget(context,
              title: "Smart Summarizer", buttonBack: false)),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      textAlign: TextAlign.center,
                      textData: "What do you want to summarize?",
                      textColor: AppColors.thirdColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      Column(
                          children: List.generate(
                              buttons.length,
                              (index) => Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.w),
                                      side: BorderSide(
                                          color: buttons[index].selected
                                              ? AppColors.primaryColor
                                              : AppColors.greyColor,
                                          width:
                                              buttons[index].selected ? 3 : 1)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.w)),
                                      onPressed: () {
                                        setState(() {
                                          for (int buttonIndex = 0;
                                              buttonIndex < buttons.length;
                                              buttonIndex++) {
                                            if (index == buttonIndex) {
                                              activeIndex = buttonIndex;
                                              buttons[buttonIndex].selected =
                                                  true;
                                            } else {
                                              buttons[buttonIndex].selected =
                                                  false;
                                            }
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.h, horizontal: 1.w),
                                        child: Column(
                                          children: [
                                            Image(
                                                height: 12.h,
                                                width: 24.w,
                                                image: AssetImage(
                                                    buttons[index].iconImage)),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomText(
                                                    textData:
                                                        buttons[index].text,
                                                    textAlign: TextAlign.center,
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))))),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                    onPressed: () {
                      switch (activeIndex) {
                        case 0:
                          GeneralRoute.navigatorPushWithContext(
                              context, const SummarizerTextScreen());
                          break;

                        case 1:
                          GeneralRoute.navigatorPushWithContext(
                              context, const SummarizerPdfScreen());
                          break;

                        case 2:
                          GeneralRoute.navigatorPushWithContext(
                              context, const SummarizerImageScreen());
                          break;
                        default:
                          print("not selected yet");
                      }
                    },
                    buttonColor: activeIndex != null
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                    buttonText: "Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonContent {
  final String text;
  final String iconImage;
  bool selected;
  ButtonContent({
    required this.text,
    required this.iconImage,
    required this.selected,
  });
}
