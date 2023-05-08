import 'package:second_opinion_app/ui/categories/categories.dart';
import 'package:second_opinion_app/ui/categories/questions.dart';
import 'package:second_opinion_app/ui/into/intro.dart';

import 'package:second_opinion_app/ui/login/login.dart';
import 'package:second_opinion_app/ui/payment/payment.dart';
import 'package:second_opinion_app/ui/profile/profile.dart';
import 'package:second_opinion_app/ui/registration/registration.dart';
import 'package:second_opinion_app/ui/second_opinion/doctors.dart';
import 'package:second_opinion_app/ui/second_opinion/payment_method.dart';
import 'package:second_opinion_app/ui/second_opinion/second_opinion.dart';
import 'package:second_opinion_app/ui/second_opinion/second_opinion_details.dart';
import 'package:second_opinion_app/ui/setting/setting.dart';
import 'package:second_opinion_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../ui/change_password/change_password.dart';
import '../../ui/home_page_view/home_page_view.dart';
import '../../ui/notification/notification.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String profile = '/profile';
  static const String registration = '/registration';
  static const String payment = '/payment';
  static const String question = '/question';
  static const String intro = '/intro';
  static const String doctors = '/doctors';
  static const String setting = '/setting';
  static const String notification = '/notification';
  static const String second_opinion_detail = '/secondOpinionDetail';
  static const String upload_screen = '/upload';
  static const String payment_method = '/paymentMethod';
  static const String change_password = '/changePassword';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => PageViewScreen(),
    categories: (BuildContext context) => CategoriesScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    registration: (BuildContext context) => Registration(),
    payment: (BuildContext context) => PaymentScreen(),
    question: (BuildContext context) => QuestionsScreen(),
    intro: (BuildContext context) => IntroScreen(),
    doctors: (BuildContext context) => DoctorsScreen(),
    setting: (BuildContext context) => SettingScreen(),
    notification: (BuildContext context) => NotificationScreen(),
    second_opinion_detail: (BuildContext context) => SecondOpinionDetailScreen(),
    upload_screen: (BuildContext context) => SecondOpinionScreen(),
    payment_method: (BuildContext context) => PaymentMethodScreen(),
    change_password: (BuildContext context) => ChangePasswordScreen(),
  };
}
