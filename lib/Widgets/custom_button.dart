import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final FontWeight? fontWeight;
  final double textFontSize;
  final double buttonHeight;
  final Color? textColor;
  final Color? buttonColor;

  const CustomButton(
      {required this.onPressed,
      required this.buttonText,
      this.buttonColor = AppColors.primaryColor,
      this.buttonHeight = 6,
      this.fontWeight = FontWeight.bold,
      this.textColor = AppColors.whiteColor,
      this.textFontSize = 14,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w), color: buttonColor),
      child: MaterialButton(
        height: buttonHeight.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontSize: textFontSize.sp,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
