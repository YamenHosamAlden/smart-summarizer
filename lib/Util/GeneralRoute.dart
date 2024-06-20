import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GeneralRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static navigatorPushWithContext(BuildContext context, Widget screen,
      {PageTransitionType type = PageTransitionType.rightToLeft}) {
    Navigator.of(context).push(PageTransition(
      //  alignment: Alignment.center,
        child: screen,
        type: type,
         isIos: true,
        duration: const Duration(milliseconds: 400)));
  }

  static navigatorPushAndRemoveScreensWithContext(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static navigatorPushAndRemoveScreensWithoutContext(
    Widget screen,
  ) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static navigatorPushWithoutContext(Widget screen,
      {PageTransitionType type = PageTransitionType.leftToRight}) {
    navigatorKey.currentState!.push(PageTransition(
        alignment: Alignment.center,
        child: screen,
        type: type,
        duration: const Duration(milliseconds: 400)));
  }

  static navigatorPobWithContext(BuildContext context,
      {PageTransitionType type = PageTransitionType.leftToRight}) {
    Navigator.of(context).pop();
  }
}
