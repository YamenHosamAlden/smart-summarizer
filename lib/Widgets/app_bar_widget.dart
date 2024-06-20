import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Util/GeneralRoute.dart';

Widget appBarWidget(BuildContext context,
    {String? title, bool buttonBack = true}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    height: 15.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10.w),
          bottomLeft: Radius.circular(10.w)),
      gradient: const LinearGradient(
        colors: [
          AppColors.primaryColor,
          AppColors.seconedaryColor,
          AppColors.thirdColor
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: buttonBack
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        GeneralRoute.navigatorPobWithContext(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                        size: 8.w,
                      ))
                ],
              ),
            ],
          )
        : null,
  );
}
