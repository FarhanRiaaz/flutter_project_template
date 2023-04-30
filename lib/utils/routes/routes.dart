import 'package:second_opinion_app/ui/categories/categories.dart';

import 'package:second_opinion_app/ui/login/login.dart';
import 'package:second_opinion_app/ui/profile/profile.dart';
import 'package:second_opinion_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../ui/home_page_view/home_page_view.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => PageViewScreen(),
    categories: (BuildContext context) => CategoriesScreen(),
    profile: (BuildContext context) => ProfileScreen(),
  };
}
