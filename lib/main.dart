import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kungwi/providers/purchases/credit/fetch_credit_provider.dart';
import 'package:kungwi/providers/purchases/monetization/monetization_status_provider.dart';
import 'package:kungwi/providers/purchases/monetization/vifurushi/vifurushi_provider.dart';
import 'package:kungwi/providers/series/series_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';
import 'package:kungwi/providers/videos/videos_provider.dart';
import 'package:kungwi/utilities/routing/routes.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(fetchTrendingSeriesProvider.future);
  await container.read(fetchTrendingVideosProvider.future);
  await container.read(fetchAllSeriesProvider.future);
  await container.read(fetchAllVideosProvider.future);

  container.read(monetizationStatusProvider.future).then((value) {
    container.read(fetchVifurushiProvider);
    container.read(sharedPreferenceInstanceProvider);
    container.read(isLoggedInProvider.future).then((value) {
      if (value == true) {
        container.read(fetchCreditProvider);
        container.read(userHasCreditsProvider);
      }
    });
    container.read(fetchVifurushiProvider);
  });
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 1));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        debugShowCheckedModeBanner: false,
        title: 'Kungwi',
        theme: FlexThemeData.light(
          scheme: FlexScheme.rosewood,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.rosewood,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 13,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        themeMode: ThemeMode.dark,
      );
    });
  }
}
