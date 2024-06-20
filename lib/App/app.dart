
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Screens/Splash/splash_screen.dart';
import 'package:smartsummarizer/Util/GeneralRoute.dart';
import 'package:smartsummarizer/Util/environment.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
          providers: [
     
            BlocProvider(
              create: (context) => ConnectivityBloc(),
            ),
        
          ],
          child:MaterialApp(
                color: AppColors.primaryColor,
                title: Environment.appName,
                theme: ThemeData(
                    colorScheme: const ColorScheme.light(
                        primary: AppColors.primaryColor)),
                debugShowCheckedModeBanner: false,
           
           
        
                navigatorKey: GeneralRoute.navigatorKey,
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                home:    SplashScreen(),
              )),
    );
  }
}
