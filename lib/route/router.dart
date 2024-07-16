import 'package:flutter/material.dart';
import 'package:smart_roof/pages/home/home.dart';
import 'package:smart_roof/pages/monitor/monitor.dart';
import 'package:smart_roof/pages/signin/signin.dart';
import 'package:smart_roof/pages/signup/signup.dart';
import 'package:smart_roof/pages/splash/splash.dart';
import 'package:smart_roof/pages/undefined/undefined.dart';
import 'package:smart_roof/route/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashPageRoute:
      return MaterialPageRoute(builder: (context) => const SplashPage());

    case signInPageRoute:
      return MaterialPageRoute(builder: (context) => const SignInPage());

    case signUpPageRoute:
      return MaterialPageRoute(builder: (context) => const SignUpPage());

    case homePageRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case monitorPageRoute:
      return MaterialPageRoute(builder: (context) => const MonitorPage());

    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedPage(
            name: settings.name!,
          ));
  }
}