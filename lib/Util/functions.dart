
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Widgets/custom_text.dart';

SnackBar errorSnackBar(BuildContext context, {required String message}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
    backgroundColor: AppColors.redColor,
    duration: const Duration(seconds: 5),
    content: Row(
      children: [
   
   
        CustomText(
          textData: message,
          textColor: AppColors.whiteColor,
        ),
      ],
    ),
  );
  return snackBar;
}



SnackBar successSnackBar(BuildContext context, {required String message}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
  
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
    backgroundColor: AppColors.greanColor,
    duration: const Duration(seconds: 5),
    content: CustomText(
      textData: message,
      textColor: AppColors.whiteColor,
    ),
  );
  return snackBar;
}
