import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:smartsummarizer/Core/Constants/app_assets.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Screens/Welcome/welcome_screen.dart';
import 'package:smartsummarizer/Util/GeneralRoute.dart';
import 'package:smartsummarizer/Util/functions.dart';
import 'package:smartsummarizer/Widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      GeneralRoute.navigatorPushAndRemoveScreensWithContext(
          context, const WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocListener<ConnectivityBloc, ConnectedState>(
          listener: (context, state) {
            if (state.message == "Connecting To Wifi") {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                context,
                message: state.message,
              ));
            }
            if (state.message == "Connecting To Mobile Data") {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                context,
                message: state.message,
              ));
            }
            if (state.message == "Lost Internet Connection") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(errorSnackBar(context, message: state.message));
            }
          },
          child: Column(
            children: [
               Container(
      width: double.infinity,
      height: 10.h,
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
          )),
   ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image:const  AssetImage(
                        AppAssets.summarizerIcon,
                      ),
                      color: AppColors.primaryColor,
                      height: 25.h,
                      width: 25.w,
                    ),
                    CustomText(
                      textData: "Smart",
                      fontSize: 30.sp,
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      textData: "Summarizer",
                      fontSize: 30.sp,
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),


                          Container(
      width: double.infinity,
      height: 10.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w)),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.seconedaryColor,
              AppColors.thirdColor
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
   ),
            ],
          )),
    );
  }
}
