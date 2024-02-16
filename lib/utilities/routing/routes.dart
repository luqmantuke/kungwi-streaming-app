// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/models/series/series_model.dart';
import 'package:kungwi/models/videos/videos_model.dart';
import 'package:kungwi/screens/account/account_page.dart';
import 'package:kungwi/screens/authentication/login_page.dart';
import 'package:kungwi/screens/authentication/signup_page.dart';
import 'package:kungwi/screens/authentication/signup_verify_page.dart';

import 'package:kungwi/screens/homescreen/homescreen.dart';
import 'package:kungwi/screens/search/search_page.dart';
import 'package:kungwi/screens/series/series_details_page.dart';
import 'package:kungwi/screens/series/series_home_page.dart';
import 'package:kungwi/screens/video/video_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreenPage(),
    ),
    GoRoute(
      name: 'searchPage',
      path: '/searchPage',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      name: 'accountPage',
      path: '/accountPage',
      builder: (context, state) => const AccountPage(),
    ),
    GoRoute(
      name: 'videoDetailsPage',
      path: '/videoDetailsPage',
      builder: (context, state) => VideoDetailsPage(
        videoData: state.extra as VideosModelData,
      ),
    ),
    GoRoute(
      name: 'seriesHomePage',
      path: '/seriesHomePage',
      builder: (context, state) => const SeriesPage(),
    ),
    GoRoute(
      name: 'seriesDetailsPage',
      path: '/seriesDetailsPage',
      builder: (context, state) => SeriesDetailsPage(
        seriesData: state.extra as SeriesModelData,
      ),
    ),
    GoRoute(
      name: 'signIn',
      path: '/signIn',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'signUp',
      path: '/signUp',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: 'signUpVerify',
      path: '/signUpVerify/:number',
      builder: (context, state) => SignUpVerifyPage(
        phoneNumber: state.pathParameters['number'].toString(),
      ),
    ),
  ],
);
