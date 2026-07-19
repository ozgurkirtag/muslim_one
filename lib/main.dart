import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controllers/app_locale_controller.dart';
import 'core/constants/app_strings.dart';
import 'core/localization/app_localization.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'screens/asma/asma_names_screen.dart';
import 'screens/daily_dhikr/daily_dhikr_screen.dart';
import 'screens/digital_tasbih/digital_tasbih_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/prayer_times/prayer_times_screen.dart';
import 'screens/qibla/qibla_screen.dart';
import 'screens/recite/recite_programs_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'widgets/global_banner_ad.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    AppLocaleController.instance.load(),
    MobileAds.instance.initialize(),
  ]);

  runApp(const MuslimOneApp());
}

class MuslimOneApp extends StatelessWidget {
  const MuslimOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLocaleController.instance,
      builder: (context, _) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          supportedLocales: AppLocalization.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return Column(
              children: [
                Expanded(
                  child: child ?? const SizedBox.shrink(),
                ),
                const GlobalBannerAd(),
              ],
            );
          },
          locale: AppLocaleController.instance.locale,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return const Locale('en');
            }

            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }

            return const Locale('en');
          },
          initialRoute: AppRoutes.home,
          routes: {
            AppRoutes.home: (_) => const HomeScreen(),
            AppRoutes.digitalTasbih: (_) => const DigitalTasbihScreen(),
            AppRoutes.recitePrograms: (_) => const ReciteProgramsScreen(),
            AppRoutes.asmaNames: (_) => const AsmaNamesScreen(),
            AppRoutes.dailyDhikr: (_) => const DailyDhikrScreen(),
            AppRoutes.settings: (_) => const SettingsScreen(),
            AppRoutes.prayerTimes: (_) => const PrayerTimesScreen(),
            AppRoutes.qibla: (_) => const QiblaScreen(),
          },
        );
      },
    );
  }
}
