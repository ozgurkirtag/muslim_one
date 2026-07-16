import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_strings.dart';
import 'core/localization/app_localization.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'screens/digital_tasbih/digital_tasbih_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/recite/recite_programs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MuslimOneApp());
}

class MuslimOneApp extends StatelessWidget {
  const MuslimOneApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      },
    );
  }
}
